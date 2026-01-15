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
  #:use-module (saayix packages fonts)
  #:use-module (channels))

(use-package-modules base
                     certs
                     commencement
                     containers
                     gnupg
                     mail
                     man
                     nss
                     package-management
                     password-utils
                     rust
                     rust-apps
                     shellutils
                     ssh
                     task-management
                     terminals
                     text-editors
                     tls
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
                    font-nerd-fira-code
                    fzf
                    gcc-toolchain
                    git
                    `(,git "send-email")
                    git-delta
                    glibc-locales
                    gnupg
                    helix
                    hydroxide
                    mandoc
                    nix
                    nss-certs
                    openssh
                    openssl
                    password-store
                    pinentry-tty
                    podman
                    podman-compose
                    ripgrep
                    starship
                    taskwarrior
                    tig
                    vim))

    ;; Below is the list of Home services.  To search for available
    ;; services, run 'guix home search KEYWORD' in a terminal.
    (services
     (list (simple-service 'channel-service home-channels-service-type
                           channels)
           (simple-service 'environment-variables-service
                           home-environment-variables-service-type
                           `(("COLORTERM" . "truecolor") ("DISPLAY" . ":0")
                             ;; For marksman, which depends on ICU which I don't know how to install
                             ;; therefore, setting this variable deactivate ICU for .Net binaries
                             ("DOTNET_SYSTEM_GLOBALIZATION_INVARIANT" . "1")
                             ("EDITOR" . "hx")
                             ("PATH" . "${HOME}/.local/bin:${HOME}/.cargo/bin:${PATH}")))
           (service home-files-service-type
                    `((".cargo/config.toml" ,(local-file
                                              "/home/woshilapin/.dot/cargo/config.toml"))
                      (".guile" ,(plain-file "guile"
                                             (string-join '("(use-modules (ice-9 readline) (ice-9 colorized))"
                                                            "(activate-readline)"
                                                            "(activate-colorized)")
                                                          "\n")))))
           (service home-xdg-configuration-files-service-type
                    `(("alacritty/alacritty.toml" ,(local-file
                                                    "/home/woshilapin/.dot/config/alacritty/alacritty.toml"))
                      ("atuin/config.toml" ,(local-file
                                             "/home/woshilapin/.dot/config/atuin/config.toml"))
                      ("containers/policy.json" ,(plain-file "policy.json"
                                                  "{\"default\": [{\"type\": \"insecureAcceptAnything\"}]}"))
                      ;; Use a fast storage ('overlayfs') instead of the default ('vfs') for Podman
                      ("containers/storage.conf" ,(plain-file "storage.conf"
                                                              (string-join '("[storage]"
                                                                             "driver = \"overlay\"")
                                                                           "\n")))
                      ;; Configure the authorized registries for podman
                      ("containers/registries.conf" ,(plain-file
                                                      "registries.conf"
                                                      "unqualified-search-registries = ['docker.io', 'ghcr.io']"))
                      ("containers/containers.conf" ,(plain-file
                                                      "containers.conf"
                                                      (string-join '("[engine]"
                                                                     "cgroup_manager=\"cgroupfs\""
                                                                     "compose_provider = [\"podman-compose\"]"
                                                                     "compose_warning_logs = false")
                                                                   "\n")))
                      ("direnv/direnv.toml" ,(plain-file "direnv.toml"
                                                         (string-join '("[global]"
                                                                        "load_dotenv = true"
                                                                        "strict_env = true")
                                                                      "\n")))
                      ("direnv/direnvrc" ,(local-file
                                           "/home/woshilapin/.dot/config/direnv/direnvrc"))
                      ("git/config" ,(local-file
                                      "/home/woshilapin/.dot/config/git/config"))
                      ("git/ignore" ,(local-file
                                      "/home/woshilapin/.dot/config/git/ignore"))
                      ("helix/config.toml" ,(local-file
                                             "/home/woshilapin/.dot/config/helix/config.toml"))
                      ("helix/languages.toml" ,(local-file
                                                "/home/woshilapin/.dot/config/helix/languages.toml"))
                      ("hongdown/config.toml" ,(local-file
                                                "/home/woshilapin/.dot/config/hongdown/config.toml"))
                      ("jj/config.toml" ,(local-file
                                          "/home/woshilapin/.dot/config/jj/config.toml"))
                      ("nix/nix.conf" ,(local-file
                                        "/home/woshilapin/.dot/config/nix/nix.conf"))
                      ("rio/config.toml" ,(local-file
                                           "/home/woshilapin/.dot/config/rio/config.toml"))
                      ("starship.toml" ,(local-file
                                         "/home/woshilapin/.dot/config/starship.toml"))
                      ("task/taskrc" ,(local-file
                                       "/home/woshilapin/.dot/config/task/taskrc"))
                      ("task/holidays.rc" ,(local-file
                                            "/home/woshilapin/.dot/config/task/holidays.rc"))
                      ("zellij/config.kdl" ,(local-file
                                             "/home/woshilapin/.dot/config/zellij/config.kdl"))))
           (service home-zsh-service-type
                    (home-zsh-configuration (zshenv (list
                                                     ;; Cannot use `home-environment-variables-service-type` because we need
                                                     ;; DIRENV_LOG_FORMAT=$'something' but the service can only do
                                                     ;; DIRENV_LOG_FORMAT="$'something'" or DIRENV_LOG_FORMAT='$\'something\'' (with literal-string)
                                                     (plain-file
                                                      "direnv-format"
                                                      (string-append
                                                       "export DIRENV_LOG_FORMAT="
                                                       (string #\$ #\')
                                                       "\\033[2mdirenv: %s\\033[0m"
                                                       (string #\')))
                                                     ;; https://www.gnupg.org/documentation/manuals/gnupg/Invoking-GPG_002dAGENT.html#Invoking-GPG_002dAGENT
                                                     ;; /!\ Cannot be done in 'home-environment-variables-service-type'
                                                     ;; because `$(tty)` must be written litteraly and `literal-string` will wrap it
                                                     ;; with single quotes `'$(tty)'` which forbid evaluation when logging in
                                                     (plain-file "gpg-tty"
                                                                 (string-join '
                                                                  ("if command -v tty > /dev/null"
                                                                   "then"
                                                                   "  export GPG_TTY=$(tty)"
                                                                   "fi") "\n"))
                                                     (plain-file "ssl"
                                                                 (string-join '
                                                                  ("export GIT_SSL_CAINFO=${HOME}/.guix-home/profile/etc/ssl/certs/ca-certificates.crt"
                                                                   "export SSL_CERT_DIR=${HOME}/.guix-home/profile/etc/ssl/certs/"
                                                                   "export SSL_CERT_FILE=${HOME}/.guix-home/profile/etc/ssl/certs/ca-certificates.crt"

                                                                   ) "\n"))))
                                            (zshrc (list (plain-file
                                                          "zsh-fpath"
                                                          "fpath=(${HOME}/.dot/zsh/completion ${fpath})")
                                                         (plain-file
                                                          "completion-init"
                                                          "autoload -Uz compinit && compinit")
                                                         (plain-file
                                                          "starship-init"
                                                          (string-join '("if command -v starship > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(starship init zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "direnv-init"
                                                          (string-join '("if command -v direnv > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(direnv hook zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "nix-init"
                                                          "source ${HOME}/.local/state/nix/profiles/profile/etc/profile.d/nix.sh")
                                                         (plain-file
                                                          "atuin-init"
                                                          (string-join '("if command -v atuin > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(atuin init zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "zoxide-init"
                                                          (string-join '("if command -v zoxide > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(zoxide init zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "docker-init"
                                                          (string-join '("if command -v docker > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(docker completion zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file "fd-init"
                                                          (string-join '("if command -v fd > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(fd --gen-completions)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file "jj-init"
                                                          (string-join '("if command -v jj > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(jj util completion zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "just-init"
                                                          (string-join '("if command -v just > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(just --completions zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "himalaya-init"
                                                          (string-join '("if command -v himalaya > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(himalaya completion zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "podman-init"
                                                          (string-join '("if command -v podman > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(podman completion zsh)\""
                                                                         "fi")
                                                                       "\n"))
                                                         (plain-file
                                                          "fnm-init"
                                                          (string-join '("if command -v fnm > /dev/null"
                                                                         "then"
                                                                         "  eval \"$(fnm completions --corepack-enabled)\""
                                                                         "fi")
                                                                       "\n"))))))
           (service home-gpg-agent-service-type
                    (home-gpg-agent-configuration (pinentry-program (file-append
                                                                     pinentry-tty
                                                                     "/bin/pinentry-tty"))))
           (service home-ssh-agent-service-type
                    (home-ssh-agent-configuration))
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
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))
                                                             (openssh-host (name
                                                                            "codeberg")
                                                                           (host-name
                                                                            "codeberg.org")
                                                                           (user
                                                                            "git")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))
                                                             (openssh-host (name
                                                                            "codeberg.org")
                                                                           (host-name
                                                                            "codeberg.org")
                                                                           (user
                                                                            "git")
                                                                           (identity-file
                                                                            "/home/woshilapin/.ssh/woshilapin@gmail.com.rsa"))))))))))
woshilapin-home-environment
