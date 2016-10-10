if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

"""" PARAMETERS
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal list

"""" SYNTASTIC CONFIGURATION
let g:syntastic_rust_checkers = ['rustc']
