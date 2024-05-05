#!/usr/bin/env bash

### environment vars
# add $HOME/.bin to PATH (this is created via dotfiles setup)
export PATH="${PATH}:$HOME/.bin"

# some programs (pip, notably) install into ~/.local/bin, add that to PATH too
export PATH="${PATH}:$HOME/.local/bin"

# bash options
export HISTCONTROL=ignoreboth
export HISTSIZE=1000
export HISTFILESIZE=5000

# suppress bash deprecation warning on MacOS
export BASH_SILENCE_DEPRECATION_WARNING=1

# XDG
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="/run/user/$UID"

# Default editor
hash vim >/dev/null 2>&1 && export EDITOR='vim' VISUAL='vim'

# Pager and man pager
if hash less >/dev/null 2>&1; then
	# set sensible default for less
	export LESS='-R'

	# Enhanced man pages
	export MANPAGER='less -R -s -M'

	# Add man page colors
	# Color scheme sourced from: https://unix.stackexchange.com/a/329092/136537
	export LESS_TERMCAP_mb=$'\e[1;31m'     # begin blink (bright red)
	export LESS_TERMCAP_md=$'\e[1;33m'     # begin bold  (bright yellow)
	export LESS_TERMCAP_so=$'\e[1;44;37m'  # begin reverse video, aka standout (bright white on blue background)
	export LESS_TERMCAP_us=$'\e[1;37m'     # begin underline  (bright white)
	export LESS_TERMCAP_me=$'\e[0m'        # reset bold/blink
	export LESS_TERMCAP_se=$'\e[0m'        # reset reverse video, aka standout
	export LESS_TERMCAP_ue=$'\e[0m'        # reset underline
	export GROFF_NO_SGR=1                  # for konsole and gnome-terminal
fi

# rg config
export RIPGREP_CONFIG_PATH="$HOME"/.ripgreprc

# shell check config
export SHELLCHECK_OPTS='--color'

### commands
# Ssh agent
# =========

# automatically start/connect to 'ssh-agent' as needed.
which keychain 2>/dev/null > /dev/null && eval $(keychain --eval --quiet --noask ~/.ssh/id_ed25519)

# Show who is here if it is a login, interactive shell
# ====================================================

if shopt -q login_shell && [[ $- == *i* ]]; then
  if [[ -f "/proc/${PPID}/cmdline" ]]; then
    case "$(tr '\0' ' ' <"/proc/${PPID}/cmdline")" in
        login* | sshd*)
            if command -v who-is-here >/dev/null; then
                who-is-here
            fi
            ;;
    esac
  fi
fi

# if running interactively, source .bashrc
[ -n "$PS1" ] && source "$HOME/.bashrc"
