# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
$env.NU_PLUGIN_DIRS = [
  ...$env.NU_PLUGIN_DIRS
  ($env.HOME | path join ".cargo" "bin")
]

$env.STARSHIP_SHELL = "nu"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = { || create_left_prompt }
$env.PROMPT_COMMAND_RIGHT = ""

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = ""
$env.PROMPT_INDICATOR_VI_INSERT = ": "
$env.PROMPT_INDICATOR_VI_NORMAL = "〉"
$env.PROMPT_MULTILINE_INDICATOR = "::: "

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
atuin init nu | save -f ($nu.data-dir | path join "vendor/autoload/atuin.nu")
zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")

$env.config.show_banner = false
$env.config.use_kitty_protocol = true
$env.config.table.mode = "none"

$env.config.keybindings ++= [{
    name: job_unfreeze
    modifier: CONTROL_SHIFT
    keycode: CHAR_Z
    mode: [emacs, vi_normal]
    event: {
        send: ExecuteHostCommand
        cmd: "job unfreeze"
    }
}]

$env.config.hooks.env_change.PWD = $env.config.hooks.env_change.PWD? | default []

# Set up for direnv
$env.config.hooks.env_change.PWD ++= [{||
    if (which direnv | is-empty) {
        # If direnv isn't installed, do nothing
        return
    }

    direnv export json
        | from json
        | default {}
        | upsert PATH { default $env.PATH | split row ':' }
        | load-env
}]
