#!/bin/bash
# The Redmi Note 10S's firmware, out of YOUR phone's Android, into fw-*/ (git ignores them:
# they are the vendor's, and nothing of the vendor's is in the repository).
#
#   fw-connsys/    CONNSYS for Wi-Fi and Bluetooth. This phone's set is soc1_0 *_2a_1
#                  (the MT6631 A-die names on spaced, soc2_2 *_2_1, are not on this phone).
#   fw-touch/      the touch controller's firmware, if the vendor tree has a file. The dts
#                  says goodix,gt9885; /proc/devinfo/tp is not on this build, so a missing
#                  file is said and is not a failure.
#
# Needs root on the phone. Read only: nothing on the phone is changed.
set -e
S=${MAPPLE_SERIAL:?set MAPPLE_SERIAL to the serial of your phone, as adb devices shows it}
HERE="$(cd "$(dirname "$0")" && pwd)"
TOP="${HERE%/device/*}"
if [ -z "${1:-}" ] && [ -d "$TOP/mapple/loader" ]; then OUT="$TOP"; else OUT="${1:-$HERE}"; fi
TMP=/data/local/tmp/mapple-fw
CONNSYS="soc1_0_ram_mcu_2a_1_hdr.bin soc1_0_ram_wifi_2a_1_hdr.bin soc1_0_ram_bt_2a_1_hdr.bin
	soc1_0_patch_mcu_2a_1_hdr.bin WIFI_RAM_CODE_soc1_0_2a_1.bin WMT_SOC.cfg BT_FW.cfg"

adb -s "$S" shell su <<EOF
set -e
rm -rf $TMP; mkdir -p $TMP/touch $TMP/connsys
for f in $CONNSYS; do cp /vendor/firmware/\$f $TMP/connsys/; done
find /vendor/firmware /odm/firmware -iname '*gt9885*' -o -iname '*goodix*' 2>/dev/null | while read -r f; do
	cp "\$f" $TMP/touch/
done
chmod 644 $TMP/connsys/* $TMP/touch/* 2>/dev/null || true
EOF
mkdir -p "$OUT/fw-touch" "$OUT/fw-connsys"
adb -s "$S" pull "$TMP/connsys/." "$OUT/fw-connsys/" >/dev/null
adb -s "$S" pull "$TMP/touch/." "$OUT/fw-touch/" >/dev/null || true
echo "rm -rf $TMP" | adb -s "$S" shell su
echo "connsys:"
ls -l "$OUT/fw-connsys"
echo "touch (empty until a file is found):"
ls -l "$OUT/fw-touch"
