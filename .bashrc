#!/usr/bin/env bash
# shellcheck disable=SC1090,SC1091
#
# executed by bash(1) for interactive, non-login shells.
#

# If not running interactively, don't do anything
if [[ "$-" != *i* ]]; then
    return
fi

# Format history
# ==============

shopt -s histappend
set +H
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=erasedups:ignorespace

# Set various bash options
# ========================

shopt -s cdspell checkwinsize dirspell direxpand cmdhist
shopt -u lithist

# Shell completion
# ================

if [[ -f /etc/bash_completion.d/git-prompt ]]; then
    source /etc/bash_completion.d/git-prompt
fi

# Source configuration files
# ==========================
export PATH="$PATH:$HOME/.local/bin"

# Source configuration files
# ==========================
shell_config_dir="${HOME}/.local/lib/shell"

for shell_file in aliases environment functions prompt 'local'; do
    if [[ -f "${shell_config_dir}/${shell_file}" ]]; then
        source "${shell_config_dir}/${shell_file}"
    fi
done

unset shell_file
unset shell_config_dir

## GCC / make
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

if test "Linux" = "$(uname -s)"
then
  alias make="make -j$(lscpu | grep '^CPU(s):' | awk '{print $2}')"
else
  alias make="make -j$(sysctl -n hw.ncpu)"
fi