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

ln -sf ~/dotfiles/vimrc ~/.vimrc
ln -sf ~/dotfiles/bashrc ~/.bashrc
ln -sf ~/dotfiles/bash_profile ~/.bash_profile
ln -sf ~/dotfiles/gemrc ~/.gemrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/Xmodmap ~/.Xmodmap

ln -sf ~/dotfiles/applications/cjk-terminal.desktop ~/.local/share/applications/cjk-terminal.desktop
ln -sf ~/dotfiles/applications/google-chrome.desktop ~/.local/share/applications/google-chrome-with-local-file-access.desktop

if [ -e /usr/bin/skype ]
then
  ln -sf ~/dotfiles/applications/skype.desktop ~/.config/autostart/skype.desktop
fi
ln -sf ~/dotfiles/applications/apply-xmodmap.desktop ~/.config/autostart/apply-xmodmap.desktop

sh ~/dotfiles/gnome_terminal.sh
