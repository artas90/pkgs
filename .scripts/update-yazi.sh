cd `dirname $0` && cd .. && _rootdir=`pwd`

update_yazi() {
  local yaziver="$1"
  local yaziarch="$2"

  wget https://github.com/sxyazi/yazi/releases/download/v$yaziver/yazi-$yaziarch-unknown-linux-musl.zip
  unzip yazi-$yaziarch-unknown-linux-musl.zip
  mv yazi-$yaziarch-unknown-linux-musl/yazi $_rootdir/yazi-$yaziver-$yaziarch-linux
  rm -rf ./yazi-$yaziarch-unknown-linux-musl ./yazi-$yaziarch-unknown-linux-musl.zip
}

update_yazi "0.3.3" "x86_64"
update_yazi "0.3.3" "aarch64"
