dot
===

All “dot” files for the configuration of the system


Setup
-----

First, you can clone this repository in `~/.dot` for example (it should work
cloned anywhere but has never been tested). You also need to pull all
submodules.

```sh
git clone https://github.com/woshilapin/dot.git ~/.dot
cd ~/.dot
git submodule update --init --recursive
```

### Configuration files

All configuration files, usually hidden files in the `HOME` directory, can be
created by running the `update.sh` script. It will create a symbolic link in
your `HOME` directory pointing to the file inside your `.dot/` directory.

### Powerline

To install Powerline, first you need to install Python3 and `virtualenv`. On a
Debian-like distribution, you can do

```sh
sudo apt install python3.7 python3-virtualenv virtualenv
```

Once this is done, you can simply run the script `powerline` (in the
`.dot/zsh/scripts/` directory), it will automatically use `pip` and
`virtualenv` to install Powerline in `~/.virtualenv`.

Powerline use a set of specific [fonts]. You
can install them with `fonts-powerline` package on Debian-like distribution. You
might need to restart the system to activate it.

[fonts]: https://github.com/powerline/fonts

### YouCompleteMe for Vim

In Vim, the installation of `YouCompleteMe` is a bit specific because it needs
to be compiled.

First of all, be sure to have pull all submodules recursively in the `.dot` git
repository.

```sh
git submodule update --init --recursive
```

Then, you will need to install headers for Python. For example, if you want to
use Python3.7, install the following packages on a Debian-like distribution.

```sh
sudo apt install python3.7 python3.7-dev
```

Finally, you should be able to compile `YouCompleteMe` with the following
command.

```sh
python3.7 ~/.dot/vim/bundle/YouCompleteMe/install.py --clangd-completer
```


Update submodules
-----------------

To update all submodules, use the following command.

```sh
git submodule update --rebase --remote
```
