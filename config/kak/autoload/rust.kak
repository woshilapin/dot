hook global WinSetOption filetype=rust %{
    # Enable LSP
    lsp-enable-window
    # Auto-format the file on save
    hook window BufWritePre .* lsp-formatting-sync
    # Configure inlay hints
    hook window -group rust-inlay-hints BufReload .* rust-analyzer-inlay-hints
    hook window -group rust-inlay-hints NormalIdle .* rust-analyzer-inlay-hints
    hook window -group rust-inlay-hints InsertIdle .* rust-analyzer-inlay-hints
    hook -once -always window WinSetOption filetype=.* %{
        remove-hooks window rust-inlay-hints
    }
}
