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
map <F4> <Esc>:!rm -Rf .build<Enter>:exec "silent !rm -f %:t:r.[a-su-zA-Z0-9]*"<Enter>:exec "silent !rm -f %:t:r.t[a-df-zA-Z0-9]*"<Enter>:exec "silent !rm -f %:t:r.te[a-wyzA-Z0-9]*"<Enter>:exec "silent !rm -f %:t:r.tex?*"<Enter>:!clear<Enter>
map <F5> <Esc>:wa<Enter>:!latexmk %<Enter>
if has("mac")
	map <F7> <Esc>:!open .build/%:r.pdf<Enter>
else
	map <F7> <Esc>:!evince %:r.pdf &<Enter>
endif
