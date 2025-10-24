### build from source

```sh
# podman run --rm --arch x86_64 -v `pwd`:/app -it ubuntu:20.04
# podman run --rm --arch aarch64 -v `pwd`:/app -it ubuntu:20.04

# -- prepare -- -- --

VERSION="4.1.1"
ARCH=`uname -m`

apt update && apt install -y build-essential autoconf libtool \
  pkg-config libpng-dev curl git

# -- build app -- -- --

git clone --depth=1 https://github.com/fukuchi/libqrencode.git && \
cd libqrencode && git checkout v$VERSION
bash autogen.sh && ./configure --enable-static --disable-shared && make

# -- copy files -- -- --

mv qrencode /app/qrencode-$VERSION-$ARCH
echo $VERSION > /app/VERSION
```
