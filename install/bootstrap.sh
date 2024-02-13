#!/bin/sh

set -eu

msg() { printf "\033[1;34m$1\033[0m\n"; }
err() { printf "\033[1;31m$1\033[0m\n" 1>&2; return 1; }
exists() { type $1 > /dev/null 2>&1; }

hash -r
if ! exists sudo; then
  err "Please install 'sudo' command."
  exit 127
fi

DIST=''
for dist in debian redhat fedora; do
  if [ -e "/etc/${dist}-release" ] || [ -e "/etc/${dist}_version" ]; then
    DIST="${dist}"
    break
  fi
done

if [ -z "${DIST}" ]; then
    err "Sorry, your operating system is not supported."
    exit 1
fi

# Install basic dependencies
msg "Installing basic packages..."
export DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true

sudo -S apt -y update
# utilities
sudo -S apt -y install git less nano htop make man bash-completion 
# for ssh
sudo -S apt -y install keychain

# Install neovim
TEMP_FOLDER="/tmp/neovim_download"

DOWNLOAD_URL=$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest \
    | grep "browser_download_url" \
    | grep "nvim-linux64.deb\"$" \
    | cut -d '"' -f 4
)

mkdir -p ${TEMP_FOLDER} && \
    curl -s -L --create-dirs -o ${TEMP_FOLDER}/nvim-linux64.deb "$DOWNLOAD_URL" && \
    dpkg --install --force-overwrite ${TEMP_FOLDER}/nvim-linux64.deb    
rm -rf ${TEMP_FOLDER}

# Remove any previous installation and install dotfiles
cd
if [ -d "dotfiles" ]; then
  msg "$HOME/dotfiles alredy exist! Removing ..."
  rm -rf $HOME/dotfiles
fi

git clone https://github.com/ra2f/dotfiles.git $HOME/dotfiles
bash $HOME/dotfiles/install/install.sh
rm -rf $HOME/dotfiles
