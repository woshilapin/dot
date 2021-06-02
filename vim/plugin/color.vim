set background=dark
set termguicolors
" help in xterm-true-color explains why we need these
let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
" NOTE: some terms don't support 'colon' but 'semicolon' instead
if &term == 'alacritty'
	let &t_8f = substitute(&t_8f, ":", ";", "g")
	let &t_8b = substitute(&t_8b, ":", ";", "g")
else
endif

let g:gruvbox_italic=1
colorscheme gruvbox
