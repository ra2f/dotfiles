#!/bin/bash

msg() { printf "\033[1;34m$1\033[0m\n"; }
set -e

dotfiles=~/dotfiles

msg "Installing ~/.config..."
[ -d ".config" ] && mv .config .config.$RANDOM.bak
ln -s $dotfiles/.config

msg "Installing ~/.local..."
[ -d ".local" ] && mv .local .local.$RANDOM.bak
ln -s $dotfiles/.local

msg "Updating ~/.bash_login..."
cp -f $dotfiles/.bash_login ~/.bash_login

msg "Updating ~/.bash_logout..."
cp -f $dotfiles/.bash_logout ~/.bash_logout

msg "Updating ~/.bashrc..."
cp -f $dotfiles/.bashrc ~/.bashrc

msg "Updating ~/.vimrc..."
cp -f $dotfiles/.vimrc ~/.vimrc

msg "Done"
