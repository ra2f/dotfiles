#!/bin/bash

msg() { printf "\033[1;34m$1\033[0m\n"; }
set -e

dotfiles=$HOME/dotfiles

msg "Installing $HOME/.config..."
cp -TR $dotfiles/.config $HOME/.config
msg "Setting up Neovim ..."
nvim --headless +PlugInstall +qa

msg "Installing $HOME/.local..."
cp -TR $dotfiles/.local $HOME/.local

msg "Updating $HOME/.bash_login..."
cp -f $dotfiles/.bash_login $HOME/.bash_login

msg "Updating $HOME/.bash_logout..."
cp -f $dotfiles/.bash_logout $HOME/.bash_logout

msg "Updating $HOME/.bashrc..."
cp -f $dotfiles/.bashrc $HOME/.bashrc

msg "Updating $HOME/.hushlogin..."
cp -f $dotfiles/.hushlogin $HOME/.hushlogin

# Source config files
msg "Sourcing config files"
source ~/.bashrc
