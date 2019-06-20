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
map <F5> <Esc>:make check --all-features<Enter>
map <F6> <Esc>:make test --all-features<Enter>

let g:syntastic_rust_checkers = []
let g:autofmt_autosave = 1

if executable('rls')
	au User lsp_setup call lsp#register_server({
				\ 'name': 'rls',
				\ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
				\ 'workspace_config': {'rust': {'all_features': 'true', 'clippy_preference': 'on'}},
				\ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'Cargo.toml'))},
				\ 'whitelist': ['rust']
				\ })
else
  echohl ErrorMsg
  echom 'Sorry, `rls` is not installed.'
  echohl NONE
endif
