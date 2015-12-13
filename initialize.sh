#!/bin/sh

# check pre-script setup
cat <<EOT
Complete these 2 steps BEFORE you run this script.

  1. configure SSH connection to GitHub

  2. execute following commands
    $ sudo apt-get update
    $ sudo apt-get dist-upgrade
    $ sudo reboot

Did you confirm? [Y/n]
EOT
read CONFIRMATION
CONFIRMATION=`echo $CONFIRMATION | tr y Y | tr -d '[\[\]]'`
case $CONFIRMATION in
  "" | Y* ) echo "proceeding...";;
  *       ) echo "aborted." && exit 0;;
esac

# use aptitude instead of apt-get
sudo apt-get install aptitude

# install fundamental tools
sudo aptitude -y install \
  build-essential curl autoconf automake lv python-software-properties sqlite3 \
  exuberant-ctags global compizconfig-settings-manager compiz-plugins-extra \
  python3 python-pip python3-pip
sudo pip install pygments

# install 3rd party softwares
sudo sed -i -e "s/^# \(.* partner\)$/\1/g" /etc/apt/sources.list
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"
sudo apt-add-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo aptitude update
sudo aptitude -y install \
  google-chrome-stable git-core oracle-java8-installer \
  nodejs dropbox python-gpgme libappindicator1 skype

# clone dotfiles and apply
cd ~
git clone git@github.com:itakeshi/dotfiles.git --depth 1
cd ~/dotfiles
sh install_dotfiles.sh

# install ruby and neovim
cd ~/dotfiles
sh install_ruby.sh
sh install_neovim.sh

# other utility softwares
sudo aptitude -y install asunder banshee ibus-mozc gimp inkscape rar

# Use CapsLock key as extra Ctrl
dconf reset /org/gnome/settings-daemon/plugins/keyboard/active
dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps']"

# reboot
cat <<EOT
Your computer has been Successfully initialized! Yay!!
Stroke any key to reboot.
EOT
read ANYKEY
sudo reboot
