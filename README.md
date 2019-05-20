dot
===

All "dot" files for the configuration of the system

# Update submodules

To update all submodules, use the following command.

    git submodule foreach git pull origin master

# Configuration files
All configuration files, usually hidden files in the `HOME` directory, can be
created by running the `update.sh` script. It will create a symbolic link in
your `HOME` directory pointing to the file inside your `.dot/` directory.

# Powerline
To install Powerline, first you need to install Python3 and `virtualenv`. On a
Debian-like distribution, you can do

```
sudo apt install python3.7 python3-virtualenv virtualenv
```

Once this is done, you can simply run the script `powerline` (in the
`.dot/zsh/scripts/` directory), it will automatically use `pip` and
`virtualenv` to install Powerline in `~/.virtualenv`.

Powerline use a set of specific [fonts](https://github.com/powerline/fonts). You
can install them with `fonts-powerline` package on Debian-like distribution. You
might need to restart the system to activate it.
