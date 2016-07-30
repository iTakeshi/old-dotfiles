#!/bin/sh

if [ ! -d ~/.vim ]
then
  ln -sf ~/dotfiles/vim ~/.vim
fi

if [ ! -d ~/.fonts ]
then
  ln -sf ~/dotfiles/fonts ~/.fonts
fi

ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig

dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

dconf load "/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/" < terminal.dconf
