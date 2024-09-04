;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(define-module (home-environments)
  #:use-module (gnu)
  #:use-module (gnu home)
  #:use-module (gnu home services)
  #:use-module (gnu home services gnupg)
  #:use-module (gnu home services guix)
  #:use-module (gnu home services shells)
  #:use-module (gnu home services ssh)
  #:use-module (gnu packages)
  #:use-module (gnu services)
  #:use-module (gnu system)
  #:use-module (guix gexp)
  #:use-module (guix channels)
  #:use-module (nongnu packages mozilla)
  #:use-module (saayix packages fonts)
  #:use-module (saayix packages text-editors)
  #:use-module (tuziwo packages starship)
  #:use-module (channels))

(use-package-modules base
                     containers
                     crates-io
                     gnupg
                     mail
                     password-utils
                     rust
                     rust-apps
                     shellutils
                     ssh
                     terminals
                     version-control
                     vim)

(define-public woshilapin-home-environment
  (home-environment
    ;; Below is the list of packages that will show up in your
    ;; Home profile, under ~/.guix-home/profile.
    (packages (list alacritty
                    bat
                    direnv
                    fd
                    firefox
                    font-nerd-fira-code
                    git
                    `(,git "send-email")
                    git-delta
                    glibc-locales
                    gnupg
                    helix
                    hydroxide
                    openssh
                    password-store
                    pinentry-tty
                    podman
                    podman-compose
                    ripgrep
                    starship
                    tig
                    vim))

    ;; Below is the list of Home services.  To search for available
    ;; services, run 'guix home search KEYWORD' in a terminal.
    (services
     (list (simple-service 'channel-service home-channels-service-type
                           channels)
           (simple-service 'environment-variables-service
                           home-environment-variables-service-type
                           `(("DISPLAY" . ":0") ("COLORTERM" . "truecolor")
                             ("EDITOR" . "hx")
                             ("PATH" . "${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}")))
           (service home-xdg-configuration-files-service-type
                    `(("alacritty/alacritty.yml" ,(local-file
                                                   "/home/woshilapin/.dot/config/alacritty/alacritty.yml"))
                      ("containers/policy.json" ,(plain-file "policy.json"
                                                  "{\"default\": [{\"type\": \"insecureAcceptAnything\"}]}"))
                      ;; Use a fast storage ('overlayfs') instead of the default ('vfs') for Podman
                      ("containers/storage.conf" ,(plain-file "storage.conf"
                                                   "[storage]\ndriver = \"overlay\""))
                      ;; Configure the authorized registries for podman
                      ("containers/registries.conf" ,(plain-file
                                                      "registries.conf"
                                                      "unqualified-search-registries = ['docker.io', 'ghcr.io']"))
                      ("direnv/direnv.toml" ,(plain-file "direnv.toml"
                                                         "[global]\nload_dotenv = true\nstrict_env = true"))
                      ("git/config" ,(local-file
                                      "/home/woshilapin/.dot/config/git/config"))
                      ("git/ignore" ,(local-file
                                      "/home/woshilapin/.dot/config/git/ignore"))
                      ("helix/config.toml" ,(local-file
                                             "/home/woshilapin/.dot/config/helix/config.toml"))
                      ("helix/languages.toml" ,(local-file
                                                "/home/woshilapin/.dot/config/helix/languages.toml"))
                      ("nix/nix.conf" ,(local-file
                                        "/home/woshilapin/.dot/config/nix/nix.conf"))
                      ("starship.toml" ,(local-file
                                         "/home/woshilapin/.dot/config/starship.toml"))
                      ("zellij/config.kdl" ,(local-file
                                             "/home/woshilapin/.dot/config/zellij/config.kdl"))))
           (service home-zsh-service-type
                    (home-zsh-configuration (zshrc (list
                                                    ;; https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html#Invoking-GPG_002dAGENT
                                                    (plain-file "gpg-tty"
                                                     "export GPG_TTY=$(tty)")
                                                    (plain-file
                                                     "starship-init"
                                                     "eval \"$(starship init zsh)\"")
                                                    (plain-file "direnv-init"
                                                     "eval \"$(direnv hook zsh)\"")))))
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
