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
