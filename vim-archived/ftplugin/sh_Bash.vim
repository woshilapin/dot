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
map <F5> <Esc>:wa<Enter>:!bash %<Enter>
