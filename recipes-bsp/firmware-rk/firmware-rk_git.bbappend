
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

#SRC_URI = "git://github.com/rockchip-linux/rkbin.git;branch=yocto-old"

SRC_URI = "git://github.com/ayufan-rock64/rkbin.git;branch=master"
SRCREV = "af17d09dee19b41f4f01e1722eaf6911fb296245"

SRC_URI += " \
    file://dptx.bin \
"

do_install_append() {
  install -d ${D}/lib/firmware/rockchip
  cp -rf ${WORKDIR}/dptx.bin ${D}/lib/firmware/rockchip/
}

PACKAGES =+ " \
  ${PN}-displayport \
"

FILES_${PN}-displayport = "/lib/firmware/*"
