### download

```sh
helixver="25.01.1"
curl -sL "artas90.github.io/pkgs/helix/helix-${helixver}-$(uname -m).tgz" | tar xz -C /opt && \
chmod 755 /opt/helix/hx && \
ln -sfv /opt/helix/hx /usr/bin/hx
```

### build from source

```sh
# rustc --print target-list
#   x86_64-unknown-linux-gnu
#   aarch64-unknown-linux-gnu

# podman run --rm --arch x86_64 -v `pwd`:/app -it ubuntu:20.04
# podman run --rm --arch aarch64 -v `pwd`:/app -it ubuntu:20.04

VERSION="25.01.1"
RUSTVER="1.76" # from rust-version at helix-editor/Cargo.toml

# -- prepare -- -- --

pkgname="helix-$VERSION-$(uname -m)"
pkgroot="/tmp/app/$pkgname"
rustarch="$(uname -m)-unknown-linux-gnu"

mkdir -p $pkgroot/opt/helix && \
cd /tmp/app

# -- install deps -- -- --

apt update && apt install -y build-essential curl git && \
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- --default-toolchain none -y && \
source "$HOME/.cargo/env" && \
rustup toolchain install $RUSTVER --profile minimal

# -- build app -- -- --

git clone https://github.com/helix-editor/helix --single-branch --branch=$VERSION --depth=1 && \
cd helix && git checkout $VERSION

cargo install --target=$rustarch --path helix-term --locked

# -- copy files -- -- --

cd $pkgroot && \
cp $HOME/.cargo/bin/hx opt/helix && \
chmod 755 opt/helix/hx && \
cp -r ../helix/runtime opt/helix && \
rm -rf opt/helix/runtime/grammars/sources && \
cp -r ../helix/contrib opt/helix

cd $pkgroot/opt && \
COPYFILE_DISABLE=1 tar --no-xattrs -cvzf "/tmp/app/$pkgname.tgz" helix
# cp "/tmp/app/$pkgname.tgz" "/app/$pkgname.tgz"
```
