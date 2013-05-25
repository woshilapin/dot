#             _                                     
#            | |                                    
#     _______| |__  _ __ ___                        
#    |_  / __| '_ \| '__/ __|                       
#   _ / /\__ \ | | | | | (__                        
#  (_)___|___/_| |_|_|  \___|                       
#                     _     _ _             _       
#                    | |   (_) |           (_)      
#  __      _____  ___| |__  _| | __ _ _ __  _ _ __  
#  \ \ /\ / / _ \/ __| '_ \| | |/ _` | '_ \| | '_ \ 
#   \ V  V / (_) \__ \ | | | | | (_| | |_) | | | | |
#    \_/\_/ \___/|___/_| |_|_|_|\__,_| .__/|_|_| |_|
#                                    | |            
#                                    |_|            
# 
# ASCII art generated on
# http://www.patorjk.com/software/taag/#p=display&h=2&v=1&c=bash&f=Doom&t=.zshrc%0Awoshilapin
# 
# The following lines were added by compinstall


# Load the oh-my-zsh configuration
ZSH=$HOME/.zsh/oh-my-zsh
CASE_SENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
plugins=(git git-flow macports osx python urltools taskwarrior)
source $ZSH/oh-my-zsh.sh

# Load the external files
for file in $HOME/.zsh/rc/* ;
do
	source $file ;
done
fpath=(~/.zsh/completion $fpath)

zstyle ':completion:*' add-space true
zstyle ':completion:*' auto-description 'Complete with: %d'
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate
zstyle ':completion:*' completions 1
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' file-sort name
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' glob 1
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent pwd .. directory
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt '%SAt %p: Hit TAB for more, or the character to insert (%l)%s'
zstyle ':completion:*' list-suffixes true
zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-@]=** r:|=**' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 3
zstyle ':completion:*' menu select=1
zstyle ':completion:*' original false
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' prompt 'You may make %e errors...'
zstyle ':completion:*' select-prompt '%SScrolling active: current selection at %p (%l)%s'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' substitute 1
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/Users/lapin/.zshrc'

autoload -U compinit && compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.zshhist
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd extendedglob
unsetopt beep nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
