#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# source global definitions (if any)
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
### Shell Options
# Enable useful shell options
shopt -s cdspell           # Correct minor spelling errors in `cd` commands
shopt -s checkhash         # Check command hash table for executables
shopt -s checkwinsize      # Update LINES and COLUMNS after each command
shopt -s cmdhist           # Save all lines of multiline commands to history
shopt -s dotglob           # Include dotfiles in filename expansion
shopt -s expand_aliases    # Enable alias expansion
shopt -s extglob           # Enable extended pattern matching
shopt -s histappend        # Append to history file instead of overwriting
shopt -s histreedit        # Allow re-editing of failed history appending
shopt -s histverify        # Verify and edit recalled history lines before execution
shopt -s hostcomplete      # Enable hostname completion for words with '@'
shopt -s lithist           # Save multiline commands with embedded newlines in history
shopt -s nocaseglob        # Enable case-insensitive globbing
shopt -s progcomp          # Enable programmable completion
shopt -s promptvars        # Expand variables in the prompt
shopt -s shift_verbose     # Print error when shifting out of bounds
shopt -s sourcepath        #  Search PATH for source files

# Disable unwanted shell options
shopt -u mailwarn          # Disable mail read notifications
shopt -u nullglob          # Prevent `ls nonexist/*` from acting like `ls`

### functions

## public functions (intended for termial use)
# find a file with a pattern in its name
# source: http://tldp.org/LDP/abs/html/sample-bashrc.html
function ff {
	find . -type f -iname '*'"$*"'*' -ls ;
}

# Define tab-completion rules for various commands to enhance usability
complete -A hostname             rsh rcp telnet rlogin ftp
complete -A export               printenv
complete -A variable             export local readonly unset
complete -A enabled              builtin
complete -A alias                alias unalias
complete -A function             function
complete -A user                 su mail finger
complete -A helptopic            help
complete -A shopt                shopt
# Prefix job names with '%' for tab completion
# Use the -P '%' option to prefix job numbers with '%' for job-related commands
complete -A job       -P '%'     fg jobs disown
complete -A directory -o default mkdir rmdir
complete -A directory -o default cd

# compression
complete -f -o default -X '!*.+(zip|ZIP)'    zip
complete -f -o default -X '!*.+(zip|ZIP)'    unzip
complete -f -o default -X '*.+(z|Z)'         compress
complete -f -o default -X '!*.+(z|Z)'        uncompress
complete -f -o default -X '*.+(gz|GZ)'       gzip
complete -f -o default -X '!*.+(gz|GZ)'      gunzip
complete -f -o default -X '*.+(bz2|BZ2)'     bzip2
complete -f -o default -X '!*.+(bz2|BZ2)'    bunzip2
# Define a pattern for compressed file extensions to exclude from completion
compressed_file_pattern='!*.+(zip|ZIP|z|Z|gz|GZ|xz|XZ|bz2|BZ2)'
complete -f -o default -X '!*.+(pl|PL)'      perl perl5
# Apply the pattern to the 'extract' command for file completion
complete -f -o default -X "$compressed_file_pattern"   extract

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

export LC_CTYPE=C

# Direnv
export DIRENV_LOG_FORMAT=""
if type direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

# Zoxide
if type zoxide &> /dev/null; then
  eval "$(zoxide init bash --cmd cd --hook prompt)"
  export _ZO_DOCTOR=0
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
