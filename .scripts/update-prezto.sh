cd `dirname $0` && cd .. && _rootdir=`pwd`

_update_prezto() {
  local ver=`date +"%Y-%m-%d-%H-%M-%S"`
  rm -rf "$_rootdir/prezto"
  mkdir "$_rootdir/prezto"
  echo -n "$ver" > "$_rootdir/prezto/VERSION"

  git clone --recursive https://github.com/sorin-ionescu/prezto.git ".zprezto"
  COPYFILE_DISABLE=1 tar --no-xattrs -cvzf "prezto/prezto-$ver.tgz" ".zprezto"

  rm -rf ".zprezto"
}
_update_prezto
