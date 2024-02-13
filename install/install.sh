#!/bin/bash

msg() { printf "\033[1;34m$1\033[0m\n"; }
set -e

dotfiles=$HOME/dotfiles

msg "Installing $HOME/.config..."
[ -d ".config" ] && mv .config .config.$RANDOM.bak
ln -s $dotfiles/.config

msg "Installing $HOME/.local..."
[ -d ".local" ] && mv .local .local.$RANDOM.bak
ln -s $dotfiles/.local

msg "Updating $HOME/.bash_login..."
cp -f $dotfiles/.bash_login $HOME/.bash_login

msg "Updating $HOME/.bash_logout..."
cp -f $dotfiles/.bash_logout $HOME/.bash_logout

msg "Updating $HOME/.bashrc..."
cp -f $dotfiles/.bashrc $HOME/.bashrc

msg "Updating $HOME/.vimrc..."
cp -f $dotfiles/.vimrc $HOME/.vimrc

msg "Done"
