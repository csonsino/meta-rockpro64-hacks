
#LICENSE = "BINARY"
#LIC_FILES_CHKSUM = "file://LICENSE.TXT;md5=564e729dd65db6f65f911ce0cd340cf9"
#NO_GENERIC_LICENSE[BINARY] = "LICENSE.TXT"

# Note - The LICENSE.txt file is missing...?
LICENSE = "CLOSED"

# ayufan

SRC_URI = "git://github.com/ayufan-rock64/rkbin;protocol=git;branch=master"

# The rockchip SRCREV is missing...?

#SRCREV = "${AUTOREV}"
SRCREV = "af17d09dee19b41f4f01e1722eaf6911fb296245"

LOADER_rk3399 = "rk33/rk3399_loader_v1.10.112_support_1CS.bin"
#rk3399_loader_v1.08.106.bin ?

MINILOADER_rk3399 = "rk33/rk3399_miniloader_v1.12.bin"
DDR_rk3399 = "rk33/rk3399_ddr_800MHz_v1.13.bin"

# Note - rockchip-gpt-img.bbclass wants the files in one location and
#        rockchip-update-img.bbclass wants them in another
do_deploy_append () {
        cp ${RKBINARY_DEPLOY_DIR}/* ${RKBINARY_DEPLOY_DIR}/../
}

# The base recipe is missing the "$" on "{S}"
deploy_prebuilt_image () {
        install -d ${RKBINARY_DEPLOY_DIR}
        [ -e ${S}/img/${SOC_FAMILY}/${UBOOT_IMG} ] && \
                cp ${S}/img/${SOC_FAMILY}/${UBOOT_IMG} ${RKBINARY_DEPLOY_DIR}/${UBOOT_IMG}
        [ -e ${S}/img/${SOC_FAMILY}/${TRUST_IMG}  ] && \
                cp ${S}/img/${SOC_FAMILY}/${TRUST_IMG} ${RKBINARY_DEPLOY_DIR}/${TRUST_IMG}
}


# rockchip

## Need to fix these paths
#
## Loader doesn't exist...
##LOADER_rk3399 = "bin/rk33/rk3399_loader_*.bin"
#
#MINILOADER_rk3328 = "bin/rk33/rk3328_miniloader_*.bin"
#
#
## Need to refine the pattern to get to a single file
#MINILOADER_rk3399 = "bin/rk33/rk3399_miniloader_v*.bin"
##MINILOADER_rk3399 = "bin/rk33/rk3399_miniloader_spinor_*.bin"
#
#DDR_rk3328 = "bin/rk33/rk3328_ddr_786MHz_*.bin"
#DDR_rk3399 = "bin/rk33/rk3399_ddr_800MHz_*.bin"
#
#
#do_deploy () {
#	  install -d ${RKBINARY_DEPLOY_DIR}
#	  [ ${DDR} ] && cp ${S}/${DDR} ${RKBINARY_DEPLOY_DIR}/${DDR_BIN}
#	  [ ${MINILOADER} ] && cp ${S}/${MINILOADER} ${RKBINARY_DEPLOY_DIR}/${MINILOADER_BIN}
#	  [ ${ATF} ] && cp ${S}/${ATF} ${RKBINARY_DEPLOY_DIR}/${ATF_BIN}
#
##	  [ ${LOADER} ] && cp ${S}/${LOADER} ${RKBINARY_DEPLOY_DIR}/${LOADER_BIN}
#
#	  # Don't remove it!
#	  echo "done"
#}
