if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

"""" PARAMETERS
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal list

"""" MAPPING
map <F5> <Esc>:wa<Enter>:!python %<Enter>

let g:syntastic_python_checkers = []
if executable('pyls')
  au User lsp_setup call lsp#register_server({
    \ 'name': 'pyls',
    \ 'cmd': {server_info->['pyls']},
    \ 'whitelist': ['python'],
    \ })
else
  echohl ErrorMsg
  echom 'Sorry, `pyls` is not installed. `pip install python-language-server` to install it'
  echohl NONE
endif
