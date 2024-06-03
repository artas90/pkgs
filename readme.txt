-- yazi -- -- --
  _yaziver="0.2.5"
  _yaziarch="x86_64"
  # OR
  _yaziarch="aarch64"
  wget https://github.com/sxyazi/yazi/releases/download/v$_yaziver/yazi-$_yaziarch-unknown-linux-musl.zip
  unzip yazi-$_yaziarch-unknown-linux-musl.zip
  mv yazi-$_yaziarch-unknown-linux-musl/yazi yazi-$_yaziver-$_yaziarch-linux
  rm -rf ./yazi-$_yaziarch-unknown-linux-musl ./yazi-$_yaziarch-unknown-linux-musl.zip

