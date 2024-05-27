;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-module (home-environments)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services ssh)
  #:use-module (gnu packages)
  #:use-module (gnu packages base)
  #:use-module (gnu packages containers)
  #:use-module (gnu packages crates-io)
  #:use-module (gnu packages gnupg)
  #:use-module (gnu packages password-utils)
  #:use-module (gnu packages rust)
  #:use-module (gnu packages rust-apps)
  #:use-module (gnu packages package-management)
  #:use-module (gnu packages ssh)
  #:use-module (gnu packages terminals)
  #:use-module (gnu packages vim)
  #:use-module (gnu services)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:use-module (channels))

(define-public woshilapin-home-environment
  (home-environment
    ;; Below is the list of packages that will show up in your
    ;; Home profile, under ~/.guix-home/profile.
    (packages (specifications->packages '("alacritty" "bat"
                                          "fd"
                                          "helix"
                                          "git"
                                          "glibc-locales"
                                          "gnupg"
                                          "openssh"
                                          "password-store"
                                          "pinentry-tty"
                                          "podman"
                                          "ripgrep"
                                          "tig"
                                          "vim")))

    ;; Below is the list of Home services.  To search for available
    ;; services, run 'guix home search KEYWORD' in a terminal.
    (services
     (list (simple-service 'channel-service home-channels-service-type
                           channels)
           (simple-service 'environment-variables-service
                           home-environment-variables-service-type
                           `(("DISPLAY" . ":0")))
           (service home-xdg-configuration-files-service-type
                    `(("alacritty/alacritty.yml" ,(local-file
                                                   "/home/woshilapin/.dot/config/alacritty/alacritty.yml"))
                      ("git/config" ,(local-file
                                      "/home/woshilapin/.dot/git/gitconfig"))
                      ("git/ignore" ,(local-file
                                      "/home/woshilapin/.dot/git/gitignore"))
                      ("helix/config.toml" ,(local-file
                                             "/home/woshilapin/.dot/config/helix/config.toml"))
                      ("helix/languages.toml" ,(local-file
                                                "/home/woshilapin/.dot/config/helix/languages.toml"))
                      ("nix/nix.conf" ,(local-file
                                        "/home/woshilapin/.dot/config/nix/nix.conf"))
                      ("zellij/config.kdl" ,(local-file
                                             "/home/woshilapin/.dot/config/zellij/config.kdl"))))
           (service home-zsh-service-type
                    (home-zsh-configuration (zshrc (list
                                                    ;; https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html#Invoking-GPG_002dAGENT
                                                    (plain-file "gpg-tty"
                                                     "export GPG_TTY=$(tty)")))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration (pinentry-program (file-append
                                                                     pinentry-tty
                                                                     "/bin/pinentry-tty"))))
           (service home-openssh-service-type
                    (home-openssh-configuration (add-keys-to-agent "yes")
                                                (hosts (list (openssh-host (name
                                                                            "tuziwo")
                                                                           (host-name
                                                                            "tuziwo.info")
                                                                           (user
                                                                            "woshilapin")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))
                                                             (openssh-host (name
                                                                            "gitlab")
                                                                           (host-name
                                                                            "gitlab.com")
                                                                           (user
                                                                            "woshilapin")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))
                                                             (openssh-host (name
                                                                            "gitlab.com")
                                                                           (host-name
                                                                            "gitlab.com")
                                                                           (user
                                                                            "woshilapin")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))
                                                             (openssh-host (name
                                                                            "github")
                                                                           (host-name
                                                                            "github.com")
                                                                           (user
                                                                            "git")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))
                                                             (openssh-host (name
                                                                            "github.com")
                                                                           (host-name
                                                                            "github.com")
                                                                           (user
                                                                            "git")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))))))))))
woshilapin-home-environment
