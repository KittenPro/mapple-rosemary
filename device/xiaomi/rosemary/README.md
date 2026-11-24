# xnu_device_xiaomi_rosemary

The Redmi Note 10S (`rosemary`: MediaTek Helio G95 / MT6785, Mali-G76 MC4, UFS, 1080 x 2400)
for Open Mapple. Its configuration (`device.conf`, `configs/`), the firmware list
(`pull-firmware.sh`, which copies CONNSYS off your own phone) and the bring-up brief
(`docs/`). `lunch mapple_rosemary` selects it.

The skeleton was written by `mapple-bringup` from LineageOS's device tree
(`android_device_xiaomi_rosemary`, lineage-22.2), the vendor kernel's dts and defconfig,
and this phone's own device tree and GPT, identifiers masked. Every status is `missing`:
nothing of Open Mapple has run on this phone yet. The brief is `docs/BRIEF.md`; what the
common drivers already name is `docs/report.md`.

Checked out at `device/xiaomi/rosemary`. Not in the upstream manifest yet. The SoC layer
is `kernel/mediatek/mt6785` (empty until a run shows a driver the common tree does not have)
and `build/mapple/tools/soc/mt6785.py`.

Two facts the trees got wrong, read on the phone before they were trusted:

- The dts says the big cores are Cortex-A75. `/proc/cpuinfo` says A55 (`0xd05`) on cpu0-5
  and A76 (`0xd0b`) on cpu6-7. `cpuinfo_max_freq` is 2.0 GHz and 2.05 GHz.
- The live tree's framebuffer reservation is `0x7bd20000`. The overlay engine scans layer 1
  at `0x7c716000`, pitch 4352, not the reservation. `adt.py` uses the scanned address.
  The GPU id `0x72110000` is a Mali-G76 (Bifrost, four cores), not the G57 on spaced.
  `mp_gpu` stays off until that is faced; spaced's Metal driver is the G57's.

The boot partition is 64 MiB and slot B is the one this phone boots. An embedded vbmeta
sits at `0x2271000` and the AVB footer in the last 64 bytes points at it. `mapple-install
chain` keeps that tail and refuses an image that would overwrite it. Flash only `boot_b`,
and only an image that chain printed the tail line for.

Licence: MIT (`LICENSE`). See `NOTICE` and `LEGAL.md`.
