#
# ~/.bashrc
#

# If not running interactively, don't do anything.
[[ $- != *i* ]] && return

# Do not murder the TERM variable... haha, I lie, it is already dead but we can resuscitate it.
# Except if you do this, vte behaves worse than it does with xterm, and I don't know why :/
#if [[ -v GUAKE_TAB_UUID && "$TERM" = xterm ]]; then
#    export TERM="vte-256color"
#fi

# Configure the prompt.
PS1='[\u@\h \w]\$ '

# Pull in bash alias definitions, if they exist.
[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

# Keep bash history
HISTSIZE=1000
HISTFILESIZE=5000
HISTCONTROL=ignoreboth
shopt -s histappend     # Don't overwrite

# Don't mangle resized windows.
shopt -s checkwinsize

# Search repos for unknown commands.
. /usr/share/doc/pkgfile/command-not-found.bash

#Environment variables.
export EDITOR=vim
export CALIBRE_SHOW_DEPRECATION_WARNINGS=1
export XDG_CONFIG_HOME=$HOME/.config
export XDG_DATA_HOME=$HOME/.local/share
export ASPROOT=/var/cache/asp/
export GCC_COLORS=1
# Disable WINE menu items.
export WINEDLLOVERRIDES=winemenubuilder.exe=d
export QT_STYLE_OVERRIDE=Fusion
export QT_QPA_PLATFORMTHEME=gtk2
#Syntax highlighting in less
export LESSOPEN="| src-hilite-lesspipe.sh %s"
export LESS="-R --ignore-case --hilite-search"
export SYSTEMD_LESS="${LESS}"
