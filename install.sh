#!/bin/sh

git submodule init
git submodule update

ln -s ~/dotfile/vim ~/.vim
ln -s ~/dotfile/vimrc ~/.vimrc
ln -s ~/dotfile/bashrc ~/.bashrc
ln -s ~/dotfile/gitconfig ~/.gitconfig
