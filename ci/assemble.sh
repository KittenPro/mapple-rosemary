#!/bin/bash
# Lay out an Open Mapple tree and drop the rosemary port on top of it.
# Upstream stays upstream; this script does not commit into those clones.
set -euo pipefail
CI="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$CI/.." && pwd)"
TREE="${1:-$ROOT/tree}"
mkdir -p "$TREE"

clone() {
	local url="$1" dest="$TREE/$2"
	if [ -d "$dest/.git" ]; then
		git -C "$dest" fetch --depth 1 origin
		git -C "$dest" reset --hard origin/HEAD
	else
		mkdir -p "$(dirname "$dest")"
		git clone --depth 1 "$url" "$dest"
	fi
}

clone https://github.com/open-mapple/mapple_build build/mapple
clone https://github.com/open-mapple/mapple_vendor vendor/mapple
clone https://github.com/open-mapple/xnu_kernel_mediatek_common kernel/mediatek/common
clone https://github.com/open-mapple/xnu_kernel_mediatek_mt6781 kernel/mediatek/mt6781
clone https://github.com/open-mapple/xnu_device_realme_spaced device/realme/spaced
clone https://github.com/open-mapple/mapple_loader mapple/loader
clone https://github.com/open-mapple/mapple_userland mapple/userland

ln -sfn mapple/envsetup.sh "$TREE/build/envsetup.sh"
rm -rf "$TREE/device/xiaomi/rosemary" "$TREE/kernel/mediatek/mt6785"
mkdir -p "$TREE/device/xiaomi" "$TREE/kernel/mediatek"
cp -a "$ROOT/device/xiaomi/rosemary" "$TREE/device/xiaomi/rosemary"
rm -rf "$TREE/device/xiaomi/rosemary/.git"
cp -a "$ROOT/kernel/mediatek/mt6785" "$TREE/kernel/mediatek/mt6785"
rm -rf "$TREE/kernel/mediatek/mt6785/.git"
cp "$ROOT/build/mapple/tools/soc/mt6785.py" "$TREE/build/mapple/tools/soc/mt6785.py"
cp "$ROOT/build/mapple/installer/mapple-install.c" "$TREE/build/mapple/installer/mapple-install.c"
cp "$CI/build-rosemary.sh" "$TREE/mapple/loader/shim/build-rosemary.sh"
chmod +x "$TREE/mapple/loader/shim/build-rosemary.sh"
cp "$ROOT/mapple/loader/shim/console.h" "$TREE/mapple/loader/shim/console.h"
python3 "$CI/mkfont.py" "$TREE/mapple/loader/mtk/loader/font8x16.h"
echo "tree: $TREE"
