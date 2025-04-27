# Using 'nix' on 'guix'

'nix' version on 'guix' is very outdated. But from a 'nix' installation, it is easy to install 'nix' itself in your profile.

```
nix profile install nixpkgs#nix
```

which is installed into your profile at `$HOME/.local/state/nix/profiles/profile/bin/nix`. You can add it to your `PATH`, but a better way is to `source` the `nix.sh` script.

```
source $HOME/.local/state/nix/profiles/profile/etc/profile.d/nix.sh
```
