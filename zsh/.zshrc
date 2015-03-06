source $ZDOTDIR/.zshenv

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory extendedglob nomatch notify
unsetopt autocd beep
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/main/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

autoload -U promptinit
promptinit

prompt redhat

setopt HIST_IGNORE_DUPS

if [ "$TERM" = "xterm-termite" ]; then
	autoload -U colors && colors
	PROMPT="%{$fg[white]%}┌ %{$fg_bold[white]%}%n%{$fg_bold[red]%}@%{$fg_no_bold[blue]%}%m%{$fg_no_bold[green]%}:%{$fg_bold[green]%}%~
	%{$fg_bold[black]%}┘ %{$fg_bold[magenta]%}%#%{$reset_color%} "
	RPROMPT="%D %T"
else
	PROMPT="┌ %n@%m:%~
┘ # "
	RPROMPT="%D %T"
fi

#PERL_MB_OPT="--install_base \"/home/main/perl5\""; export PERL_MB_OPT;
#PERL_MM_OPT="INSTALL_BASE=/home/main/perl5"; export PERL_MM_OPT;

# # Make keys behave
# create a zkbd compatible hash;
typeset -A key

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Delete]}"   ]]  && bindkey  "${key[Delete]}"   delete-char
[[ -n "${key[Up]}"       ]]  && bindkey  "${key[Up]}"       up-line-or-history
[[ -n "${key[Down]}"     ]]  && bindkey  "${key[Down]}"     down-line-or-history
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
    function zle-line-init () {
        printf '%s' "${terminfo[smkx]}"
    }
    function zle-line-finish () {
        printf '%s' "${terminfo[rmkx]}"
    }
    zle -N zle-line-init
    zle -N zle-line-finish
fi
# #

# bash style help
autoload -U run-help
autoload run-help-git
autoload run-help-svn
autoload run-help-svk
unalias run-help
alias help=run-help

# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Prompt
PROMPT="%{$fg[white]%}┌ %{$fg_bold[white]%}%n%{$fg_bold[red]%}@%{$fg_no_bold[blue]%}%m%{$fg_no_bold[green]%}:%{$fg_bold[green]%}%E%~
%{$fg_bold[black]%}┘ %{$fg_bold[magenta]%}%#%{$reset_color%} "
RPROMPT="%D %T"

# Directory hashes.
if [[ -d $HOME/projects ]]; then
    for d in $HOME/projects/*(/); do
        hash -d ${d##*/}=$d
    done
fi

# Colourful man pages.
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
        LESS_TERMCAP_md=$'\E[01;38;5;74m' \
        LESS_TERMCAP_me=$'\E[0m' \
        LESS_TERMCAP_se=$'\E[0m' \
        LESS_TERMCAP_so=$'\E[38;5;246m' \
        LESS_TERMCAP_ue=$'\E[0m' \
        LESS_TERMCAP_us=$'\E[04;38;5;146m' \
        man "$@"
}

source $ZDOTDIR/aliases.sh
source $ZDOTDIR/xdg_compat.sh

# vim: ts=4:sw=4:et
