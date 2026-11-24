# Match report: Redmi Note 10S

Which of our code already mentions each thing the trees say this phone has (a base address or a part name found in the
files of `--ours`). `named` means a driver or table of ours mentions it, not that it works here: read it before turning it on.
`not named` means nothing of ours mentions it: a new driver, or an address or name spelled another way.

| area | fact | status | where |
| --- | --- | --- | --- |
| soc | cores | named | `EXTERNAL_HEADERS/acpi/Acpi.h`, `EXTERNAL_HEADERS/corecrypto/cckprng.h`, `EXTERNAL_HEADERS/corecrypto/ccrng_fortuna.h`, `EXTERNAL_HEADERS/mach-o/fat.h` |
| soc | gicd | named | `bsd/netinet/cbrtf.c`, `libkern/libkern/OSSerializeBinary.h`, `mtk/loader/mtkloader.c`, `osfmk/arm/trap.h` |
| soc | uart | named | `mtk/loader/diag.c`, `mtk/loader/mtkloader.c` |
| soc | toprgu | named | `bsd/dev/usb_link.c`, `iokit/Kernel/arm/MapplePlatformExpert.cpp`, `mtk/loader/diag.c`, `mtk/loader/diag_start.S` |
| memory | ramoops | named | `mtk/loader/mtkdbg.h` |
| memory | lk_fb | not named | - |
| display | ovl0 | named | `iokit/Kernel/arm/MappleFramebuffer.cpp` |
| display | lk_fb | not named | - |
| keys | keypad | named | `iokit/Kernel/arm/hid/MTKKeypad.cpp` |
| pmic | pwrap | named | `iokit/Kernel/arm/MTKPwrap.cpp`, `mtk/loader/mtkpwrap.h` |
| pmic | chip | not named | - |
| thermal | controller | named | `osfmk/arm64/mt6781_cpufreq.c` |
| storage | controller | named | `mtk/loader/bringup.h`, `mtk/loader/mtkloader.c`, `shim/bootrec.c` |
| gpu | mali | not named | - |
| gpu | mfgcfg | named | `iokit/Kernel/arm/MappleGPU.cpp`, `osfmk/arm64/mtk_gpu_probe.c` |
| wifi_bt | consys | named | `bsd/dev/mt6631_wifi.c` |
| wifi_bt | chip | named | `bsd/conf/files`, `bsd/dev/mapple_sysctl.c`, `bsd/dev/mt6631_wifi.c`, `bsd/dev/mt6631_wlan.c` |
| wifi_bt | wifi | named | `bsd/arm/fasttrap_isa.h`, `bsd/dev/mt6631_wifi.c`, `bsd/netinet/cbrtf.c`, `iokit/Kernel/arm/MappleGPU.cpp` |
| wifi_bt | btif | named | `bsd/dev/mt6631_wifi.c` |
| sensor_hub | scp | named | `osfmk/arm64/mt6781_scp.c` |
| sensor_hub | sspm | not named | - |
| audio | afe | not named | - |
| audio | codec_node | not named | - |
| audio | amplifiers_on | not named | - |
| audio | amp_nodes | not named | - |
| camera | sensors | not named | - |
| camera | isp | not named | - |
| torch | flash | not named | - |

## Not covered by sources (a phone probe settles each)

