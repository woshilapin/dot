source "/home/woshilapin/.config/kak/plugins/fzf/rc/fzf.kak"                # loading base fzf module
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/fzf-file.kak"   # fzf file chooser
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/fzf-buffer.kak" # switching buffers with fzf
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/fzf-search.kak" # search within file contents
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/fzf-cd.kak"     # change server's working directory
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/fzf-ctags.kak"  # search for tag in your project ctags file
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/fzf-vcs.kak"    # VCS base module
source "/home/woshilapin/.config/kak/plugins/fzf/rc/modules/VCS/fzf-git.kak" # Git support module

map global normal <c-p> ': fzf-mode<ret>'

hook global ModuleLoaded fzf %{
    set-option global fzf_file_command 'fd'
    set-option global fzf_highlight_command 'bat'
    set-option global fzf_implementation 'sk'
}
