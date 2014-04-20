#!/bin/sh

###############################################################################
### IMPORTANT #################################################################
###############################################################################
# REQUIREMENTS
#
# Configure SSH conection to GitHub.
###############################################################################
# BEFORE run this script, it is strongly recommended to exec following commmand
#
# #!/bin/sh
# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get autoremove
# sudo reboot
###############################################################################

read -p "Home-use?" yn
case $yn in
    [Yy]* ) home_use=true;;
    [Nn]* ) home_use=false;;
    * ) echo "Please answer yes or no.";;
esac

sudo apt-get -y install aptitude
sudo aptitude -y install \
  curl build-essential autoconf automake paco mercurial ibus-mozc lv \
  python-software-properties sqlite3 gimp inkscape rar

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
sudo apt-key adv --keyserver pgp.mit.edu --recv-keys 5044912E
# Workaround: repo for trusty is not served.
# sudo add-apt-repository "deb http://linux.dropbox.com/ubuntu $(lsb_release -sc) main"
sudo add-apt-repository -y "deb http://linux.dropbox.com/ubuntu saucy main"
sudo apt-add-repository -y ppa:git-core/ppa
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository -y ppa:chris-lea/node.js
sudo apt-get update
sudo aptitude -y install \
  google-chrome-stable git-core oracle-java8-installer \
  nodejs dropbox python-gpgme libappindicator1

cd ~
git clone git@github.com:iTakeshi/dotfiles.git
cd dotfiles
sh install.sh

sudo aptitude -y install \
  ttf-mscorefonts-installer ttf-vlgothic ttf-sawarabi-gothic ttf-sazanami-gothic \
  ttf-sazanami-mincho ttf-konatu ttf-hanazono ttf-kochi-gothic ttf-umeplus \
  ttf-komatuna ttf-monapo ttf-umefont otf-ipafont-gothic otf-ipafont-mincho \
  otf-ipaexfont-gothic otf-ipaexfont-mincho ttf-takao-pgothic ttf-takao-mincho

mkdir -p ~/.src

sudo aptitude -y install \
  libffi-dev libgdbm-dev libreadline-dev libncurses-dev libyaml-dev \
  libcurl4-openssl-dev zlib1g-dev libssl-dev libxml2-dev libxslt-dev sqlite3 libsqlite3-dev
cd ~/.src
ruby_major=2
ruby_minor=1
ruby_teeny=1
ruby_folder="ruby-${ruby_major}.${ruby_minor}.${ruby_teeny}"
ruby_tar="${ruby_folder}.tar.gz"
ruby_url="http://cache.ruby-lang.org/pub/ruby/${ruby_major}.${ruby_minor}/${ruby_tar}"
checksum=""
touch $ruby_tar
while [ "$checksum" != "e57fdbb8ed56e70c43f3" ]
do
  rm $ruby_tar
  wget $ruby_url
  checksum=`md5sum $ruby_tar | cut -c 1-20`
done
tar -xf $ruby_tar
rm $ruby_tar
cd $ruby_folder
./configure --without-readline # XXX avoid compile bug
make && sudo paco -D make install
# sudo gem update --system
# sudo gem update
# sudo gem install bundler pry pry-debugger nokogiri

sudo aptitude -y install \
  libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev \
  libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev \
  python3-dev lua5.2 liblua5.2-dev libperl-dev
cd ~/.src
hg clone https://code.google.com/p/vim/
cd vim
./configure \
  --with-features=huge \
  --disable-darwin \
  --disable-selinux \
  --enable-luainterp \
  --enable-perlinterp \
  --enable-pythoninterp \
  --enable-python3interp \
  --enable-rubyinterp \
  --enable-cscope \
  --enable-multibyte \
  --enable-xim \
  --enable-fontset \
  --enable-gui=gnome2 \
  --enable-fail-if-missing \
  --with-python3-config-dir=/usr/lib/python3.3/config-3.3m-x86_64-linux-gnu
make && sudo paco -D make install

if $home_use
then
  sed -i -e "s/^# \(.* partner\)$/\1/g" sources.list
  sudo apt-get update
  sudo aptitude -y install xbmc asunder skype
fi

# cleaning up
sudo rm /etc/apt/sources.list.d/google.list
sudo rm /etc/apt/sources.list.d/google.list.save
