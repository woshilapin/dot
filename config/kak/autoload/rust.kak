hook global WinSetOption filetype=rust %{
    # Enable LSP
    lsp-enable-window

    # Auto-formatting on save
    hook window BufWritePre .* lsp-formatting-sync

    # Configure inlay hints (only on save)
    hook window -group rust-inlay-hints BufWritePost .* rust-analyzer-inlay-hints
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window rust-inlay-hints
    }
}
