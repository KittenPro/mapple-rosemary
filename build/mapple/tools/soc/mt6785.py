# MediaTek MT6785 (Helio G95), for mkadt.py. Addresses from the phone's own tree and the
# vendor dts (mapple-bringup BRIEF.md). The big cores are Cortex-A76 (MIDR 0x41:0xd0b on
# cpu6 and cpu7); the dts says A75 and is wrong, as it was on spaced.
NAMES = dict(platform='mapple,platform', io='mapple-io', display='mapple,display', fbcon='mapple-fbcon',
             ufs='mapple-ufs', firmware='mapple-shim')
# The root's SoC entry and the cores' compatible still say what ios-sweet's tree said; nothing reads them.
ROOT_COMPAT = 'qcom,sm7150'
CPU_COMPAT = ('qcom,kryo470', 'ARM,v8')
GICD = (0x0c000000, 0x40000)
GICR = (0x0c040000, 0x200000)
TIMEBASE = 13000000
VTIMER_INTID = 27       # DT timer, the standard virtual timer (PPI 27)
CPU_HZ = (2000000000, 2050000000)       # cpu0 cpuinfo_max_freq, cpu6 cpuinfo_max_freq
BIG_FROM = 6
UFS = ('mediatek,mt8183-ufshci', 0x11270000, 0x4000)   # ufshci@11270000 (DT size 0x2300, one 16K page)
