#!/bin/sh

if [ ! -d ~/.src ]
then
  mkdir ~/.src
fi
cd ~/.src

gtags_major=6
gtags_minor=5
gtags_patch=1

gtags_dir="global-${gtags_major}.${gtags_minor}.${gtags_patch}"
gtags_tar="${gtags_dir}.tar.gz"
gtags_url="ftp://ftp.gnu.org/pub/gnu/global/${gtags_tar}"

wget $gtags_url
tar -xf $gtags_tar
cd $gtags_dir
./configure
make
sudo make install
