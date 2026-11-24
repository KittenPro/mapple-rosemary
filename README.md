# mapple-rosemary

Open Mapple for the Redmi Note 10S, built on GitHub's macOS runners.

Linux cannot run their `mka`. It stops unless Xcode's `iig` is present, and the kernel
build wants the Kernel Debug Kit and `darwin-xnu-build`. GitHub retired the `macos-14`
image (2 November 2026), which was the last one that shipped Xcode 15.4. This workflow
uses `macos-15` and, for the loader and the shim, does not call `mka` at all: those two
are freestanding and build with clang and `ld.lld` on Linux too.

A push builds only the kernel, on `macos-15`. The loader, the shim and `mapple-install`
build on the Linux host (`ci/build.sh`) and are not repeated there.

Their MediaTek patches compile only for `MACHINE_CONFIG=MT6781`, so the job builds the
common kernel under that name. It is not a rosemary board config yet. Xcode 15.4 left
with the retired `macos-14` image; the job uses whichever Xcode on `macos-15` still has `iig`.

`ci/assemble.sh` clones the Open Mapple repositories and lays this port over them.
Nothing of Apple's and no phone firmware is in this repository.
