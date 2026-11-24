#!/bin/bash
# The shim for the Redmi Note 10S. Same MediaTek path as spaced (MT6781_SHIM: UFS, holes,
# boot-args record) with this phone's framebuffer. mka looks for build-$DEVICE.sh.
set -euo pipefail
cd "$(dirname "$0")"
CFLAGS="--target=aarch64-none-elf -O2 -ffreestanding -nostdlib -fno-pic -mgeneral-regs-only -mstrict-align -fno-stack-protector -Wall -Wextra -DMT6781_SHIM -DROSEMARY $*"
LLD=${LLD:-ld.lld}
mkdir -p out/rosemary
OBJS=()
for f in start.S mt6781.c console.c fdt.c holes.c identity.c loader.c bootrec.c; do
	o=out/rosemary/${f%.*}.o
	clang $CFLAGS -c $f -o $o
	OBJS+=($o)
done
[ -z "${CHECK_ABS:-}" ] || python3 "$CHECK_ABS" out/rosemary/mt6781.o out/rosemary/console.o out/rosemary/fdt.o out/rosemary/holes.o out/rosemary/identity.o out/rosemary/loader.o out/rosemary/bootrec.o
$LLD -T shim.ld --build-id=none -N "${OBJS[@]}" -o out/rosemary/shim.elf
$LLD -T shim.ld --build-id=none -N "${OBJS[@]}" --oformat=binary -o out/rosemary/Image
size=$(python3 -c "import struct; d=open('out/rosemary/Image','rb').read(64); print(struct.unpack_from('<Q', d, 16)[0])")
python3 -c "f=open('out/rosemary/Image','r+b'); f.truncate($size)"
ls -l out/rosemary/Image
