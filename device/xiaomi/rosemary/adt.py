# The Redmi Note 10S's device tree values, for build/mapple/tools/mkadt.py (with tools/soc/mt6785.py). Written by mapple-bringup from the
# vendor's trees. Empty values are for you to fill: mkadt stops on one and names it.

# RAM XNU gets: (base, size): start of the largest free range (16 KiB pages)
RAM = (0xffe00000, 0xbe200000)
# The live tree's framebuffer reservation is 0x7bd20000. The overlay engine scans layer 1 at
# 0x7c716000, pitch 4352 (1088 pixels: LK rounds 1080 up to 32). The reservation is not the scan.
FB = dict(base=0x7c716000, width=1080, height=2400, stride=4352)
FB['size'] = (FB['stride'] * FB['height'] + 0x3fff) & ~0x3fff
ECID = 0x524f534500000001  # 'ROSE' + 1, synthetic, the same shape as spaced's 'SPAC' + 1
PRODUCT_NAME = 'Redmi Note 10S'
# 8-bit BGRA, as spaced: CoreAnimation then does not compose in extended-range 10-bit.
DISPLAY_GAMUT = 'sRGB'
# serial-number is a placeholder the shim overwrites at each boot with the boot loader's serial. model and regulatory: the tree's PRODUCT_MODEL, which may be a sibling model's; check ro.product.model on your own phone.
ABOUT = dict(serial='MAPPLE0000000000', model='M2101K7BNY', region='', regulatory='M2101K7BNY')


def devices(a, ph, phandle, gic_ph, ecid, flags):
    # /arm-io devices, one node per chip the drivers should find (keypad, PMIC, touch, ...): none yet. BRIEF.md lists the
    # facts for each, and the match report which drivers exist.
    return []
