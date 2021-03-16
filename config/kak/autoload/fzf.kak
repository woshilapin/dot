# enter user mode for fzf
map global normal <c-p> ': fzf-mode<ret>'

# specify options for when fzf module is loaded
hook global ModuleLoaded fzf %{
    set-option global fzf_file_command 'fd --hidden'
    set-option global fzf_highlight_command 'bat'
    set-option global fzf_implementation 'sk'
    set-option global fzf_preview_pos 'down'
    set-option global fzf_preview_height '75%'
    set-option global fzf_preview_width '62%'
}

# load the fzf module
require-module fzf
