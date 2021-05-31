" Vim syntax file
" Language:	JavaScript
" Maintainer:	woshilapin <woshilapin@tuziwo.info>
" URL:		https://github.com/woshilapin/dot
" Changes:	(ss) add Symbol
"		(ss) add template strings
"		(ss) add for-of loops
" Last Change:	2015 Jul 03: update to ECMAScript6

" tuning parameters:
" unlet javaScript_fold

syn region  javaScriptStringS	       start=+`+  skip=+\\\\\|\\'+  end=+`\|$+	contains=javaScriptSpecial,@htmlPreproc

syn keyword javaScriptRepeat		of
syn keyword javaScriptType		Symbol Set Map WeakSet WeakMap

if exists("javaScript_fold")
    syn match	javaScriptFunction	"\<function\*\>"
    syn region	javaScriptFunctionFold	start="\<function\*\>.*[^};]$" end="^\z1}.*$" transparent fold keepend

    syn sync match javaScriptSync	grouphere javaScriptFunctionFold "\<function\*\>"
else
    syn keyword javaScriptFunction	function*
endif

" vim: ts=8
