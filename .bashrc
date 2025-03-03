#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# source global definitions (if any)
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

### shell options
# set shell options
#set -o ignoreeof        # prevent Ctrl+D from exiting terminal
shopt -s cdspell        # allow minor misspellings in `cd` commands
shopt -s checkhash      # reference command hash table for executables
shopt -s checkwinsize   # update LINES and COLUMNS after each command
shopt -s cmdhist        # save all lines of multiline commands to history
shopt -s dotglob        # allow globing filenames beginning with '.'
shopt -s expand_aliases # use bash aliases
shopt -s extglob        # use pattern matching features (ref `man bash`)
shopt -s histappend     # append to history file instead of overwriting
shopt -s histreedit     # allow user to re-edit failed history appending
shopt -s histverify     # edit recalled history line before executing
shopt -s hostcomplete   # attempt hostname completion on word containing '@'
shopt -s lithist        # save multiline commands to history with embedded \n
shopt -s nocaseglob     # use case insensitive globs on filename expansion
shopt -s progcomp       # use bash programmable completion
shopt -s promptvars     # expand vars in prompt
shopt -s shift_verbose  # print error if shifting out of bounds
shopt -s sourcepath     # reference PATH to find executables

# unset shell options
shopt -u mailwarn       # don't spam mail read notifications
shopt -u nullglob       # `ls nonexist/*` should fail, not act like `ls`

### functions

## public functions (intended for termial use)
# find a file with a pattern in its name
# source: http://tldp.org/LDP/abs/html/sample-bashrc.html
function ff {
	find . -type f -iname '*'"$*"'*' -ls ;
}

# common completions
complete -A hostname             rsh rcp telnet rlogin ftp ping disk
complete -A export               printenv
complete -A variable             export local readonly unset
complete -A enabled              builtin
complete -A alias                alias unalias
complete -A function             function
complete -A user                 su mail finger
complete -A helptopic            help
complete -A shopt                shopt
complete -A stopped   -P '%'     bg
complete -A job       -P '%'     fg jobs disown
complete -A directory            mkdir rmdir
complete -A directory -o default cd

# compression
complete -f -o default -X '*.+(zip|ZIP)'     zip
complete -f -o default -X '!*.+(zip|ZIP)'    unzip
complete -f -o default -X '*.+(z|Z)'         compress
complete -f -o default -X '!*.+(z|Z)'        uncompress
complete -f -o default -X '*.+(gz|GZ)'       gzip
complete -f -o default -X '!*.+(gz|GZ)'      gunzip
complete -f -o default -X '*.+(bz2|BZ2)'     bzip2
complete -f -o default -X '!*.+(bz2|BZ2)'    bunzip2
complete -f -o default -X '!*.+(zip|ZIP|z|Z|gz|GZ|xz|XZ|bz2|BZ2)'   extract

complete -f -o default -X '!*.pl'            perl perl5

# Source configuration files
# ==========================
shell_config_dir="${HOME}/.local/lib/shell"

for shell_file in aliases environment exports functions history prompt; do
    if [[ -f "${shell_config_dir}/${shell_file}" ]]; then
        source "${shell_config_dir}/${shell_file}"
    fi
done

unset shell_file
unset shell_config_dir

# Paths
export XDG_CONFIG_HOME="$HOME/.config"

# Direnv
export DIRENV_LOG_FORMAT=""
if type direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

# Zoxide # z command
if type zoxide &> /dev/null; then
  eval "$(zoxide init bash --cmd cd --hook prompt)"
fi

# Starship
if type starship &> /dev/null; then
  eval "$(starship init bash)"
fi

# Kubectl
if type kubectl &> /dev/null; then
  source <(kubectl completion bash)
fi

eval "$(ssh-agent -s)"
ssh-add --apple-use-keychain ~/.ssh/id_ed25519

# Show who is here if it is a login, interactive shell
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
fi

# Paths
export XDG_CONFIG_HOME="$HOME/.config"
