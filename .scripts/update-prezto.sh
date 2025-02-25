cd `dirname $0` && cd .. && _rootdir=`pwd`

cpomz() {
  local pdir=".zprezto/contrib/omz-$1"
  cp -r "ohmyzsh/plugins/$1" "$pdir"
  mv "$pdir/$1.plugin.zsh" "$pdir/omz-$1.plugin.zsh"
}
_update_prezto() {
  local ver=`date +"%Y-%m-%d-%H-%M-%S"`
  rm -rf "$_rootdir/prezto"
  mkdir "$_rootdir/prezto"
  echo -n "$ver" > "$_rootdir/prezto/VERSION"

  git clone --recursive https://github.com/sorin-ionescu/prezto.git ".zprezto"
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git

  rm -rf .zprezto/.git*
  echo                           >> ".zprezto/init.zsh"
  echo "unset -f zprezto-update" >> ".zprezto/init.zsh"

  mkdir .zprezto/contrib
  echo 'Plugins from github.com/ohmyzsh/ohmyzsh' > .zprezto/contrib/readme.txt
  cpomz nvm
  cpomz fzf
  cpomz ssh
  cpomz cp
  cpomz urltools
  cpomz zsh-interactive-cd
  cpomz zsh-navigation-tools

  COPYFILE_DISABLE=1 tar --no-xattrs -czf "prezto/prezto-$ver.tgz" ".zprezto"
  rm -rf ".zprezto"
  rm -rf ohmyzsh
}
_update_prezto
