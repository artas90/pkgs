### build from source

```sh
# podman run --rm --arch x86_64 -v `pwd`:/app -it ubuntu:20.04
# podman run --rm --arch aarch64 -v `pwd`:/app -it ubuntu:20.04

# -- prepare -- -- --

apt update && apt install -y build-essential curl git

MVER=`date +"%Y.%-m.%-d"`
GVER=`curl -s https://go.dev/VERSION?m=text | head -n 1 | sed 's/^go//'`
ARCH=`uname -m`
case "$(uname -m)" in
  x86_64)  ARCH="amd64" ;;
  aarch64) ARCH="arm64" ;;
  *)       echo "error: unknown architecture"; return ;;
esac

# -- install deps -- -- --

gopkg="go$GVER.linux-$ARCH.tar.gz"
curl "https://storage.googleapis.com/golang/$gopkg" -o $gopkg
tar -C /usr/local -xzf $gopkg
export PATH=$PATH:/usr/local/go/bin

# -- build app -- -- --

git clone --depth=1 https://github.com/zyedidia/micro
cd micro & git tag v$MVER & git checkout v$MVER
make build

# -- copy files -- -- --

mv micro /app/micro-$MVER-$(uname -m)
echo $MVER > /app/VERSION
