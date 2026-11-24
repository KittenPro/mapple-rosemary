# mapple-rosemary

Open Mapple for the Redmi Note 10S, built on GitHub's macOS runners.

Linux cannot run their `mka`. It stops unless Xcode's `iig` is present, and the kernel
build wants the Kernel Debug Kit and `darwin-xnu-build`. GitHub retired the `macos-14`
image (2 November 2026), which was the last one that shipped Xcode 15.4. This workflow
uses `macos-15` and, for the loader and the shim, does not call `mka` at all: those two
are freestanding and build with clang and `ld.lld` on Linux too.

What a push builds, on `ubuntu-24.04` and `macos-15`:

- `mtkloader.bin`
- the rosemary shim (`shim.Image`)
- `mapple-install`, including the AVB-tail check

The kernel job is manual (`workflow_dispatch`). Their MediaTek patches compile only for
`MACHINE_CONFIG=MT6781`, so that job builds the common kernel under that name. It is not
a rosemary kernel yet.

`ci/assemble.sh` clones the Open Mapple repositories and lays this port over them.
Nothing of Apple's and no phone firmware is in this repository.
