# Launch 'kak-lsp'
evaluate-commands %sh{kak-lsp --kakoune -s $kak_session}

set-option global lsp_diagnostic_line_error_sign '🔴'
set-option global lsp_diagnostic_line_warning_sign '🟠'

lsp-inlay-diagnostics-enable global
