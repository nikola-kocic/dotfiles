autoload -U colors ; colors
zstyle ':completion:*' menu select

# Highlight the matching part of the menu
zstyle -e ':completion:*' list-colors 'thingy=${PREFIX##*/} reply=( "=(#b)($thingy)(?)*=00=$color[green]=$color[bg-green]" )'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/nikola/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Prompt with full path
PS1=$'%{\e[0;32m%}%m%{\e[0m%}:%~> '
export PS1

setopt inc_append_history       # instantly append
setopt hist_ignore_all_dups     # no duplicate

# Don't use because of same handling of Ctrl+W and Alt+Backspace {{{
    #autoload -U select-word-style
    #select-word-style bash
# }}}

# from https://github.com/andreafrancia/dot-files/blob/master/.zshrc
# Bash-like Ctrl+W and Alt+Backspace{{{

    # Ctrl+W
    unix-word-rubout() {
        local WORDCHARS='*?/_-.[]~=&;!#$%^(){}<>'
        zle backward-kill-word
    }
    zle -N unix-word-rubout
    bindkey '^W' unix-word-rubout

    # Alt+backspace
    WORDCHARS='*?[]~&;!$%^<>'
    bindkey '\e^h' backward-kill-word

# }}}

#Rebind HOME and END to do the decent thing:
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[5~" up-line-or-history
bindkey "^[[6~" down-line-or-history

source ~/.sh-common
