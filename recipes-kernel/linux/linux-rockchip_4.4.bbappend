
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

#SRCREV = "${AUTOREV}"
SRCREV = "0407701328f71606404770802ebf59dcb47494ac"
LINUX_VERSION = "4.4.154"

SRC_URI += " \
    file://001_fix_rk3399-rockpro64_device_tree.patch \
"

