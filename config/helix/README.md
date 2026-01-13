How to install Helix
====================

- Download the release from https://github.com/helix-editor/helix/releases
- cp helix\_release/hx $( which hx ) # should be in ‘~/.local/bin/hx’
- rm -r ~/.config/helix/runtime && cp -r helix\_release/runtime
    ~/.config/helix/runtime
- cp helix\_release/contrib/completions/hx.zsh ~/.zsh/completions/\_hx
