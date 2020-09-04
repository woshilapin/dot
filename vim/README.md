dot-vim
=======

vim configuration files

# Build `vim`

Here is the configuration used to build `vim`.

```bash
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

# `fzf`
[`fzf.vim`] is a `vim` plugin depending on the [`fzf`] binary. `fzf` binary can
be installed directly from `vim` thanks to a Vimscript in [`fzf`] repository
providing an install function. This is the preferred install solution since it
should keep both [`fzf`] and [`fzf.vim`] in synchronization (same maintainer).

```
:call fzf#install()
```

[`fzf.vim`]: https://github.com/junegunn/fzf.vim
[`fzf`]: https://github.com/junegunn/fzf

# Configuration for Rust
For Rust auto-compilation and auto-completion to work, you'll need a few
extra-component to install.

## Auto-completion
Auto-completion is achieved through the `coc` vim plugin. However, it also needs
[RLS] and [rust-analyzer] to be installed.

Once this is done, you also need to install a few Coc extensions. Open Vim and
type the following commands (needed only once).

```vim
:CocInstall coc-rust-analyzer
:CocInstall coc-rls
```

[RLS]: https://github.com/rust-lang/rls
[rust-analyzer]: https://github.com/rust-analyzer/rust-analyzer
