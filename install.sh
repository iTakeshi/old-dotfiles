#!/bin/sh

git submodule init
git submodule update

if [ ! -d ~/.vim ]
then
  ln -sf ~/dotfiles/vim ~/.vim
fi

if [ ! -d ~/.fonts ]
then
  ln -sf ~/dotfiles/fonts ~/.fonts
fi

if [ ! -d ~/.gconf/apps/gnome-terminal/profiles ]
then
  ln -sf ~/dotfiles/gnome-terminal-profiles ~/.gconf/apps/gnome-terminal/profiles
fi

ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/Xmodmap ~/.Xmodmap
