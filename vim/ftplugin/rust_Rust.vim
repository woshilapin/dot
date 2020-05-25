if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

"""" PARAMETERS
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal expandtab
setlocal list
compiler cargo
noremap <F5> <Esc>:Cargo check --all-features<Enter>
noremap <F6> <Esc>:Cargo test --all-features<Enter>

if has("autocmd")
	autocmd BufWritePre <buffer> call rustfmt#Format()
endif

let g:syntastic_rust_checkers = []
let g:autofmt_autosave = 1

