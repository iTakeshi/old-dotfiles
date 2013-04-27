#!/bin/sh

git submodule init
git submodule update

ln -sf ~/dotfile/vim ~/.vim
ln -sf ~/dotfile/vimrc ~/.vimrc
ln -sf ~/dotfile/bashrc ~/.bashrc
ln -sf ~/dotfile/gitconfig ~/.gitconfig
