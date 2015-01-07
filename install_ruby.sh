cd ~/.src
ruby_major=2
ruby_minor=2
ruby_teeny=0
ruby_folder="ruby-${ruby_major}.${ruby_minor}.${ruby_teeny}"
ruby_tar="${ruby_folder}.tar.gz"
ruby_url="http://cache.ruby-lang.org/pub/ruby/${ruby_major}.${ruby_minor}/${ruby_tar}"
checksum=""
touch $ruby_tar
while [ "$checksum" != "cd03b28fd0b555970f5c" ]
do
  rm $ruby_tar
  wget $ruby_url
  checksum=`md5sum $ruby_tar | cut -c 1-20`
done
tar -xf $ruby_tar
rm $ruby_tar
cd $ruby_folder
./configure
make && sudo paco -D make install
