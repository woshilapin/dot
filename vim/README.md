dot-vim
=======

vim configuration files

# Build `vim`

Here is the configuration used to build `vim`.

```
git clone https://github.com/vim/vim.git
cd vim/
./configure \
	--prefix=/usr
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

# Configuration for Rust
For Rust auto-compilation and auto-completion to work, you'll need a few
extra-component to install.

## Auto-completion
Auto-completion is achieved through the `asyncomplete` vim plugin. However, it
also needs [Racer](https://github.com/racer-rust/racer) to be installed.

## Auto-compilation
Auto-compilation is achieved thanks to the LSP protocol.
[`vim-lsp`](https://github.com/prabirshrestha/vim-lsp) is the Vim plugin that is
capable of reading LSP protocol. However, you might need to install a few Rust
component for it (see
[documentation](https://github.com/prabirshrestha/vim-lsp/wiki/Servers-Rust)).
