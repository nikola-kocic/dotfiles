#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Always apply variables from "${HOME}/.config/environment.d/" ( https://github.com/systemd/systemd/issues/7641#issuecomment-693117066 )
set -a
. /dev/fd/0 <<EOF
$(/usr/lib/systemd/user-environment-generators/30-systemd-environment-d-generator)
EOF
set +a

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
PS1='[\u@\h \w]\$ '

stty -ixon  # Disable Ctrl+S freezing, use it for forward history search
source "${HOME}/.sh-common"
