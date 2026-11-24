#!/bin/bash
# The parts of a rosemary build that do not need Xcode, an IPSW or the Kernel Debug Kit.
# mka itself refuses to start without Xcode 15.4's iig, so this calls the same tools it would.
set -euo pipefail
CI="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$CI/.." && pwd)"
TREE="${1:-$ROOT/tree}"
OUT="${2:-$ROOT/out/ci}"
bash "$CI/assemble.sh" "$TREE"
mkdir -p "$OUT"
export LLD="${LLD:-ld.lld}"

echo "== loader =="
(
	cd "$TREE/mapple/loader/mtk/loader"
	printf 'CONFIG_SOC="mt6785"\n' > "$TREE/mapple/loader/.config"
	TOUCH_IMG=none LLD="$LLD" ./build.sh -DXNU_SHIM=1 -DROOT_ROOM_MIB=0 -fno-stack-protector
	cp mtkloader.bin "$OUT/"
)

echo "== shim =="
(
	cd "$TREE/mapple/loader/shim"
	LLD="$LLD" ./build-rosemary.sh
	cp out/rosemary/Image "$OUT/shim.Image"
)

echo "== installer =="
ZDIR="$OUT/zlib-src"
if [ ! -f "$ZDIR/zlib-1.3.1/zlib.h" ]; then
	mkdir -p "$ZDIR"
	curl -fsSL -o "$ZDIR/zlib.tar.gz" https://github.com/madler/zlib/releases/download/v1.3.1/zlib-1.3.1.tar.gz
	tar -xzf "$ZDIR/zlib.tar.gz" -C "$ZDIR"
fi
z="$ZDIR/zlib-1.3.1"
zig cc -target aarch64-linux-musl -static -O2 -s -I"$z" \
	"$z/adler32.c" "$z/crc32.c" "$z/deflate.c" "$z/inflate.c" "$z/inffast.c" \
	"$z/inftrees.c" "$z/trees.c" "$z/zutil.c" \
	"$TREE/build/mapple/installer/mapple-install.c" \
	-o "$OUT/mapple-install"

ls -l "$OUT"
