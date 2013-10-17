#!/bin/sh

###############################################################################
### IMPORTANT #################################################################
###############################################################################
#
# BEFORE run this script, it is strongly recommended to exec following commmand
#
# #!/bin/sh
# sudo apt-get update
# sudo apt-get upgrade
# sudo apt-get autoremove
# sudo reboot
###############################################################################

sudo apt-get install aptitude
sudo aptitude install curl build-essential autoconf automake checkinstall mercurial ibus-mozc lv python-software-properties banshee sqlite3 python-pip python-virtualenv virtualenvwrapper

wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-add-repository ppa:git-core/ppa
sudo add-apt-repository ppa:webupd8team/java
sudo add-apt-repository ppa:chris-lea/node.js
sudo apt-get update
sudo aptitude install google-chrome-stable git-core oracle-java7-installer nodejs

cd ~
git clone git@github.com:iTakeshi/dotfiles.git
sh dotfiles/install.sh
sh dotfiles/gnome_terminal.sh

sudo aptitude install ttf-mscorefonts-installer ttf-vlgothic ttf-sawarabi-gothic ttf-sazanami-gothic ttf-sazanami-mincho ttf-konatu ttf-hanazono ttf-kochi-gothic ttf-umeplus ttf-komatuna ttf-monapo ttf-umefont otf-ipafont-gothic otf-ipafont-mincho otf-ipaexfont-gothic otf-ipaexfont-mincho ttf-takao-pgothic ttf-takao-mincho

mkdir -p ~/.src

sudo aptitude install libffi-dev libgdbm-dev libreadline-dev libncurses-dev libyaml-dev libcurl4-openssl-dev zlib1g-dev libssl-dev libxml2-dev libxslt-dev sqlite3 libsqlite3-dev
cd ~/.src
wget ftp://ftp.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p247.tar.bz2
tar -xf ruby-2.0.0-p247.tar.bz2
rm ruby-2.0.0-p247.tar.bz2
cd ruby-2.0.0-p247/
.configure
make && sudo checkinstall
sudo gem update --system
sudo gem update
sudo gem install bundler pry pry-debugger nokogiri

sudo aptitude install libncurses5-dev libgnome2-dev libgnomeui-dev libgtk2.0-dev libatk1.0-dev libbonoboui2-dev libcairo2-dev libx11-dev libxpm-dev libxt-dev python-dev python3-dev lua5.2 liblua5.2-dev libperl-dev
cd ~/.src
hg clone https://code.google.com/p/vim/
cd vim
./configure --with-features=huge --disable-darwin --disable-selinux --enable-luainterp --enable-perlinterp --enable-pythoninterp --enable-python3interp --enable-rubyinterp --enable-cscope --enable-multibyte --enable-xim --enable-fontset --enable-gui=gnome2 --enable-fail-if-missing --with-python3-config-dir=/usr/lib/python3.3/config-3.3m-x86_64-linux-gnu
make && sudo checkinstall

mkdir -p ~/ecell

cd ~/ecell
sudo aptitude install docbook-utils doxygen gsl-bin libboost-dev libboost-python-dev libgsl0-dbg libgsl0-dev libsbml5-python docbook-xsl python-gtk2-dev
git clone git@github.com:iTakeshi/ecell3.git
cd ecell3
./autogen.sh
./configure
make && sudo checkinstall

cd ~/ecell
git clone git@github.com:ecell/ecellp.git
