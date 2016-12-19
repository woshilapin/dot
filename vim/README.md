dot-vim
=======

vim configuration files

# Build `vim`

Here is the configuration used to build `vim`.

```
./configure \
	--disable-gui \
	--disable-gtk-check \
	--disable-motif-check \
	--disable-athena-check \
	--disable-gtk2-check \
	--disable-kde-check \
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
```
