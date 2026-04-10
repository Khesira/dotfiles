# ~/.bashrc: executed by bash(1) for non-login shells.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
shopt -s histappend
shopt -s checkwinsize

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# SSH askpass
export SUDO_ASKPASS=/usr/lib/ssh/ssh-askpass

# Editor
export EDITOR='vim'
export SVN_EDITOR='vim'

# WSL graphics
export GALLIUM_DRIVER=d3d12
export LIBVA_DRIVER_NAME=d3d12

# FZF configuration
export FZF_CTRL_R_OPTS="--sort --exact"

if [ -f /usr/share/fzf/key-bindings.bash ]; then
    . /usr/share/fzf/key-bindings.bash
fi

if [ -f /usr/share/fzf/completion.bash ]; then
    . /usr/share/fzf/completion.bash
fi

# WSL2 SSH Agent
if [ -x /usr/bin/wsl2-ssh-agent ]; then
    eval "$(/usr/bin/wsl2-ssh-agent)"
fi

# Bash completion
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# User aliases
if [ -f "$HOME/.bash_aliases" ]; then
    . "$HOME/.bash_aliases"
fi

# Custom Bash Config
if [ -f "$HOME/.local.bashrc" ]; then
    . "$HOME/.local.bashrc"
fi
