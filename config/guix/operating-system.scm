;;; GNU Guix --- Functional package management for GNU
;;; Copyright © 2022 Alex Griffin <a@ajgrf.com>
;;; Copyright © 2022 Mathieu Othacehe <othacehe@gnu.org>
;;;
;;; This file is part of GNU Guix.
;;;
;;; GNU Guix is free software; you can redistribute it and/or modify it
;;; under the terms of the GNU General Public License as published by
;;; the Free Software Foundation; either version 3 of the License, or (at
;;; your option) any later version.
;;;
;;; GNU Guix is distributed in the hope that it will be useful, but
;;; WITHOUT ANY WARRANTY; without even the implied warranty of
;;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;; GNU General Public License for more details.
;;;
;;; You should have received a copy of the GNU General Public License
;;; along with GNU Guix.  If not, see <http://www.gnu.org/licenses/>.

(define-module (operating-system
                 )
  #:use-module (gnu bootloader)
  #:use-module (gnu image)
  #:use-module (gnu packages admin)
  #:use-module (gnu packages base)
  #:use-module (gnu packages certs)
  #:use-module (gnu packages guile)
  #:use-module (gnu packages linux)
  #:use-module (gnu packages shells)
  #:use-module (gnu services)
  #:use-module (gnu services base)
  #:use-module (gnu services guix)
  #:use-module (gnu system)
  #:use-module (gnu system file-systems)
  #:use-module (gnu system image)
  #:use-module (gnu system shadow)
  #:use-module (guix build-system trivial)
  #:use-module (guix gexp)
  #:use-module (guix packages)
  #:use-module ((guix licenses)
                #:select (fsdg-compatible))
  #:use-module (home-environments)
  #:export (wsl-boot-program wsl-os wsl2-image))

(define (wsl-boot-program user)
  "Program that runs the system boot script, then starts a login shell as
USER."
  (program-file "wsl-boot-program"
                (with-imported-modules '((guix build syscalls))
                                       #~(begin
                                           (use-modules (guix build syscalls))
                                           (unless (file-exists?
                                                    "/run/current-system")
                                             (let ((shepherd-socket
                                                    "/var/run/shepherd/socket"))
                                               ;; Clean up this file so we can wait for it later.
                                               (when (file-exists?
                                                      shepherd-socket)
                                                 (delete-file shepherd-socket))

                                               ;; Child process boots the system and is replaced by shepherd.
                                               (when (zero? (primitive-fork))
                                                 (let* ((system-generation (readlink
                                                                            "/var/guix/profiles/system"))
                                                        (system (readlink (string-append
                                                                           (if
                                                                            (absolute-file-name?
                                                                             system-generation)
                                                                            ""
                                                                            "/var/guix/profiles/")
                                                                           system-generation))))
                                                   (setenv "GUIX_NEW_SYSTEM"
                                                           system)
                                                   (execl #$(file-append
                                                             guile-3.0
                                                             "/bin/guile")
                                                          "guile"
                                                          "--no-auto-compile"
                                                          (string-append
                                                           system "/boot"))))

                                               ;; Parent process waits for shepherd before continuing.
                                               (while (not (file-exists?
                                                            shepherd-socket))
                                                      (sleep 1))))

                                           (let* ((pw (getpw #$user))
                                                  (shell (passwd:shell pw))
                                                  (sudo #+(file-append sudo
                                                           "/bin/sudo"))
                                                  (args (cdr (command-line)))
                                                  (uid (passwd:uid pw))
                                                  (gid (passwd:gid pw))
                                                  (runtime-dir (string-append
                                                                "/run/user/"
                                                                (number->string
                                                                 uid))))
                                             ;; Save the value of $PATH set by WSL.  Useful for finding
                                             ;; Windows binaries to run with WSL's binfmt interop.
                                             (setenv "WSLPATH"
                                                     (getenv "PATH"))

                                             ;; /run is mounted with the nosuid flag by WSL.  This prevents
                                             ;; running the /run/setuid-programs.  Remount it without this flag
                                             ;; as a workaround.  See:
                                             ;; https://github.com/microsoft/WSL/issues/8716.
                                             (mount #f
                                                    "/run"
                                                    #f
                                                    MS_REMOUNT
                                                    #:update-mtab? #f)

                                             ;; Create XDG_RUNTIME_DIR for the login user.
                                             (unless (file-exists? runtime-dir)
                                               (mkdir runtime-dir)
                                               (chown runtime-dir uid gid))
                                             (setenv "XDG_RUNTIME_DIR"
                                                     runtime-dir)

                                             ;; Start login shell as user.
                                             (apply execl
                                              sudo
                                              "sudo"
                                              "--preserve-env=WSLPATH,XDG_RUNTIME_DIR"
                                              "-u"
                                              #$user
                                              "--"
                                              shell
                                              "-l"
                                              args))))))

(define dummy-package
  (package
    (name "dummy")
    (version "0")
    (source
     #f)
    (build-system trivial-build-system)
    (arguments
     `(#:modules ((guix build utils))
       #:target #f
       #:builder (begin
                   (use-modules (guix build utils))
                   (let* ((out (assoc-ref %outputs "out"))
                          (dummy (string-append out "/dummy")))
                     (mkdir-p out)
                     (call-with-output-file dummy
                       (const #t))))))
    (home-page #f)
    (synopsis #f)
    (description #f)
    (license (fsdg-compatible "dummy"))))

(define dummy-bootloader
  (bootloader (name 'dummy-bootloader)
              (package
                dummy-package)
              (configuration-file "/dev/null")
              ;; Deviates from /gnu/system/images/wsl2.scm
              ;; See https://lists.gnu.org/archive/html/help-guix/2024-03/msg00042.html
              (configuration-file-generator (lambda* rest
                                              (computed-file
                                               "dummy-bootloader"
                                               #~(mkdir #$output))))
              (installer #~(const #t))))

(define dummy-kernel
  dummy-package)

(define (dummy-initrd . _rest)
  (plain-file "dummy-initrd" ""))

(define-public wsl-os
  (operating-system
    (host-name "gnu")
    (timezone "Europe/Paris")
    (bootloader (bootloader-configuration
                  (bootloader dummy-bootloader)))
    (kernel dummy-kernel)
    (initrd dummy-initrd)
    (initrd-modules '())
    (firmware '())
    (file-systems (cons (file-system
                          (device "/dev/sdb")
                          (mount-point "/")
                          (type "ext4")
                          (mount? #t))
                        ;; Add these for support of 'cgroup2', useful for 'podman'
                        %control-groups))
    (users (cons* (user-account
                    (name "woshilapin")
                    (group "users")
                    (supplementary-groups '("wheel")) ;allow use of sudo
                    (password "")
                    (shell (file-append zsh "/bin/zsh"))
                    (comment "woshilapin main account"))
                  (user-account
                    (inherit %root-account)
                    (shell (wsl-boot-program "woshilapin")))
                  %base-user-accounts))
    (services
     (list (service guix-service-type
                    (guix-configuration (substitute-urls
                                         ;; Reverse the list so official 'guix' substitutes (%default-substitute-urls) are first
                                         (reverse (cons*
                                                   "https://substitutes.nonguix.org" ;nonguix
                                                   "https://cuirass.genenetwork.org" ;guix (new, so not in default)
                                                   %default-substitute-urls)))
                                        (authorized-keys (cons* (plain-file
                                                                 "genenetwork.pub"
                                                                 (string-append
                                                                  "(public-key\n"
                                                                  "  (ecc\n"
                                                                  "    (curve Ed25519)\n"
                                                                  "    (q #9578AD6CDB23BA51F9C4185D5D5A32A7EEB47ACDD55F1CCB8CEE4E0570FBF961#)

"
                                                                  "  )\n"
                                                                  ")"))
                                                          (plain-file
                                                           "nonguix.pub"
                                                           (string-append
                                                            "(public-key\n"
                                                            "  (ecc\n"
                                                            "    (curve Ed25519)\n"
                                                            "    (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)

"
                                                            "  )\n"
                                                            ")"))
                                                          %default-authorized-guix-keys))))
           (service udev-service-type) ;needed for 'podman'
           (service guix-home-service-type
                    `(("woshilapin" ,woshilapin-home-environment)))
           ;; Autosave the current 'operating-system.scm' into '/etc/config.scm'
           (simple-service 'my-operating-system etc-service-type
                           `(("config.scm" ,(local-file (assoc-ref (current-source-location)
                                                                   'filename)))))
           ;; For Podman configuration, see
           ;; https://gooseandquill.blog/posts/install-rootless-podman-on-guix.pdf
           ;; Configuration of uid and gid for Podman usage
           ;; If on a foreign distro, you can read the following tutorial
           ;; https://jcvassort.open-web.fr/how-to-setup-podman-on-debian-11/
           ;; sudo usermod --add-subuids 100000-165535 --add-subgids 100000-165535 woshilapin
           ;; sudo apt install uidmap # Might need the `newuidmap` binary
           ;; podman system migrate
           (simple-service 'etc-subuid etc-service-type
                           (list `("subuid" ,(plain-file "subuid"
                                                         (string-append
                                                          "root:0:65536\n"
                                                          "woshilapin:100000:65536\n")))))
           (simple-service 'etc-subgid etc-service-type
                           (list `("subgid" ,(plain-file "subgid"
                                                         (string-append
                                                          "root:0:65536\n"
                                                          "woshilapin:100000:65536\n")))))
           (service special-files-service-type
                    `(("/bin/sh" ,(file-append zsh "/bin/zsh"))
                      ("/bin/mount" ,(file-append util-linux "/bin/mount"))
                      ("/usr/bin/env" ,(file-append coreutils "/bin/env"))))))))

(define wsl2-image
  (image (inherit (os->image wsl-os
                             #:type wsl2-image-type))
         (name 'wsl2-image)))

wsl2-image
