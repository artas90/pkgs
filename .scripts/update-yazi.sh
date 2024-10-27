cd `dirname $0` && cd .. && _rootdir=`pwd`

update_yazi() {
  local ver="$1"
  local arch="$2"
  local os="$3"

  local pkg="yazi-${arch}-${os}"
  local exe=""
  if [ $os = "pc-windows-msvc" ]; then
    exe=".exe"
  fi

  wget https://github.com/sxyazi/yazi/releases/download/v${ver}/${pkg}.zip
  unzip ${pkg}.zip
  mv "${pkg}/yazi${exe}" "$_rootdir/yazi-${ver}-${arch}-${os}${exe}"
  rm -rf ./${pkg} ./${pkg}.zip
}

update_yazi "0.3.3" "x86_64"  "unknown-linux-musl"
update_yazi "0.3.3" "x86_64"  "pc-windows-msvc"
update_yazi "0.3.3" "aarch64" "unknown-linux-musl"
update_yazi "0.3.3" "aarch64" "pc-windows-msvc"
