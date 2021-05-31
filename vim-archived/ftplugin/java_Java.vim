if exists("b:did_ftplugin")
	finish
endif
let b:did_ftplugin = 1

"""" PARAMETERS
setlocal foldmethod=marker
setlocal foldmarker={,}
setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=0
setlocal list

compiler maven2
map <F5> <Esc>:wa<Enter>:make<Enter>
