#!/bin/sh

git submodule init
git submodule update

if [ ! -d ~/.vim ]
then
  ln -sf ~/dotfiles/vim ~/.vim
fi
ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/Xmodmap ~/.Xmodmap
