#!/bin/sh

# check pre-script setup
cat <<EOT
Complete these 2 steps BEFORE you run this script.

  1. configure SSH connection to GitHub

  2. execute following commands
    $ sudo apt update
    $ sudo apt dist-upgrade
    $ sudo reboot

Did you confirm? [Y/n]
EOT
read CONFIRMATION
CONFIRMATION=`echo $CONFIRMATION | tr y Y | tr -d '[\[\]]'`
case $CONFIRMATION in
  "" | Y* ) echo "proceeding...";;
  *       ) echo "aborted." && exit 0;;
esac

# install fundamental tools
sudo apt -y install \
  build-essential curl autoconf automake lv python-software-properties sqlite3 \
  exuberant-ctags global compizconfig-settings-manager compiz-plugins-extra \
  python3 python-pip python3-pip clang $(check-language-support) \
  unity-tweak-tool nfs-common lua5.2 lua5.2-dev libperl-dev doxygen \
  libffi-dev libgdbm-dev libreadline-dev libncurses-dev libyaml-dev \
  libcurl4-openssl-dev zlib1g-dev libssl-dev libxml2-dev libxslt-dev sqlite3 \
  libsqlite3-dev libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev \
  mysql-server mysql-client nfs-common
sudo pip install pygments mycli

# use fcitx
im-config -n fcitx

# install 3rd-party softwares {{{
sudo sed -i -e "s/^# \(.* partner\)$/\1/g" /etc/apt/sources.list
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"
sudo apt-add-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/java
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt update
sudo apt -y install \
  google-chrome-stable git-core oracle-java8-installer \
  nodejs dropbox python-gpgme libappindicator1
# }}}

# clone dotfiles and apply
cd ~
git clone git@github.com:itakeshi/dotfiles.git --depth 1
cd ~/dotfiles
sh install_dotfiles.sh

# install from source {{{
if [ ! -d $HOME/usr/src ]
then
  mkdir -p $HOME/usr/src
fi

# ruby {{{
cd $HOME/usr/src

ruby_major=2
ruby_minor=3
ruby_teeny=1

ruby_dir="ruby-${ruby_major}.${ruby_minor}.${ruby_teeny}"
ruby_tar="${ruby_dir}.tar.gz"
ruby_url="http://cache.ruby-lang.org/pub/ruby/${ruby_major}.${ruby_minor}/${ruby_tar}"

wget $ruby_url
tar -xf $ruby_tar
rm $ruby_tar
cd $ruby_dir
./configure --prefix=$HOME/usr/
make
make install

gem update --system
gem update
gem install bundler pry pry-byebug nokogiri
# }}}

# vim {{{
cd $HOME/usr/src

git clone https://github.com/vim/vim
cd vim
./configure --prefix=$HOME/usr/ --enable-fail-if-missing --enable-luainterp \
    --enable-perlinterp --enable-pythoninterp --enable-python3interp \
    --enable-rubyinterp --enable-cscope --enable-multibyte \
    --disable-darwin --disable-selinux --with-x --with-gnome
make
make install
# }}}

# }}}

# scala
wget www.scala-lang.org/files/archive/scala-2.11.8.deb
sudo dpkg -i scala-2.11.8.deb
rm scala-2.11.8.deb
echo "deb https://dl.bintray.com/sbt/debian /" | sudo tee -a /etc/apt/sources.list.d/sbt.list
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 642AC823
sudo apt update
sudo apt install sbt

# other utility softwares
sudo apt -y install asunder banshee gimp inkscape rar

# Use CapsLock key as extra Ctrl
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

# reboot
cat <<EOT
Your computer has been Successfully initialized! Yay!!
Stroke any key to reboot.
EOT
read ANYKEY
sudo reboot
