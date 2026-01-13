dot-vim
=======

vim configuration files


Build `vim`
-----------

Here is the configuration used to build `vim`.

```sh
# You can either `git clone` from official repository
# git clone https://github.com/vim/vim.git
# or get the last release from
# https://github.com/vim/vim/releases
cd vim/
./configure \
    --prefix=/usr \
    --disable-gui \
    --disable-motif-check \
    --disable-athena-check \
    --disable-gtk2-check \
    --with-features=huge \
    --enable-mzschemeinterp=yes \
    --enable-luainterp=yes \
    --enable-perlinterp=yes \
    --enable-pythoninterp=yes \
    --enable-python3interp=yes \
    --enable-tclinterp=yes \
    --enable-rubyinterp=yes \
    --enable-selinux \
    --enable-cscope \
    --enable-channel \
    --enable-multibyte \
    --enable-largefile \
    --enable-acl \
    --enable-nls
make
sudo make install
```


`fzf`
-----

[`fzf.vim`] is a `vim` plugin depending on the [`fzf`] binary. `fzf` binary can
be installed directly from `vim` thanks to a Vimscript in [`fzf`] repository
providing an install function. This is the preferred install solution since it
should keep both [`fzf`] and [`fzf.vim`] in synchronization (same maintainer).

```vimscript
:call fzf#install()
```

[`fzf.vim`]: https://github.com/junegunn/fzf.vim
[`fzf`]: https://github.com/junegunn/fzf


Auto-completion
---------------

Auto-completion is achieved through the `coc` vim plugin. NodeJS must be
installed. Try `:CocUpdate` to see if all the extensions are installed.
