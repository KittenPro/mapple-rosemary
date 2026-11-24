# xnu_kernel_mediatek_mt6785

The MediaTek MT6785 (Helio G95) layer of the kernel, laid over `kernel/mediatek/common` when
building for the Redmi Note 10S (`rosemary`). Empty on purpose: nothing here has run on this
SoC under Open Mapple, and the common tree's drivers are turned on from `device.conf` one at
a time. A file lands here only when a run shows the common driver is not this chip's.

Checked out at `kernel/mediatek/mt6785`. Not in the upstream manifest yet.

Licence: MIT (`LICENSE`); `LICENSE.APSL` for files built into Apple's XNU, when there are any.
