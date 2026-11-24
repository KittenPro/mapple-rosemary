# Legal

Open Mapple is an independent research project. It is **not affiliated with, endorsed by, or
connected to Apple Inc., MediaTek Inc. or Xiaomi.** iOS, iPhone and Metal are trademarks of
Apple Inc.; Helio and MediaTek are trademarks of MediaTek Inc.; Xiaomi and Redmi are trademarks
of their owner. They are named only to say what this works with.

What this repository does **not** contain, and must never contain:

- **Nothing of Apple's**: no iOS binary, image, cache, library, shader library, font, picture or
  screenshot, no header derived from iOS firmware. The iOS user space is built on the user's own
  machine from an IPSW the user downloads from Apple.
- **Nothing of the vendor's**: no firmware of the phone (touch controller, CONNSYS Wi-Fi/Bluetooth,
  sensor hub, GPU), no partition image, no device tree taken off a phone. `pull-firmware.sh` copies
  the firmware from the user's own phone into `fw-*/`, which git ignores.
- **Nothing to impersonate an Apple device to Apple's services**: no keys, certificates, activation
  data or real serial numbers. The serial the loader gives iOS is the placeholder
  `MAPPLE0000000000`.

Unlocking the bootloader, rooting and flashing are at the user's own risk. On this phone the
boot image must keep the stock partition's tail: the AVB footer in the last 64 bytes points at
an embedded vbmeta, and a footer that does not is fatal in LK.

If you believe a file here infringes anyone's rights, open an issue and it will be removed.
None of this is legal advice.
