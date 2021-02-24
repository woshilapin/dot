hook global WinSetOption filetype=rust %{
    # Enable LSP
    lsp-enable-window
    # Configure inlay hints
    hook window -group rust-inlay-hints BufWritePost .* rust-analyzer-inlay-hints
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window rust-inlay-hints
    }
}
