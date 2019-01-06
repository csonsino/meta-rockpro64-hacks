meta-rockpro64-hacks
====================

Yocto BSP layer for the PINE64 ROCKPro64 board- https://www.pine64.org/?page_id=61454

Description
-----------
This is a hardware specific BSP overlay for the PINE64 ROCKPro64 board.

**I would prefer if this layer did not exist.**

It would be nice if the [meta-rockchip layer](https://github.com/rockchip-linux/meta-rockchip) fully supported this board.  Recent commits to [rockchip-linux kernel](https://github.com/rockchip-linux/kernel) have started to add some of the necessary files (although the dts does not seem to be usable), but the meta-rockchip layer seems to be behind.

In order to create a bootable ROCKPro64 image, this layers essentially uses some files from [ayufan's rock64 repo](https://github.com/ayufan-rock64) instead of the default rockchip files.

Notes
-----
* Serial Console - With the resulting image, the serial console can be connected as described in the [HOW TO - Connect the serial console](https://forum.pine64.org/showthread.php?tid=6387) forum post. The TX line can be connected before power on and can be used with U-Boot, but it must be disconnected before booting the Linux Kernel.  Any attempts to connect the TX line after the kernel starts to boot seems to result in a complete system freeze.  After the kernel boots, HDMI + USB Keyboard can be used, or additional packages can be included in the image to enable and configure Ethernet network access.
* Boot Warnings - During boot, several driver and firmware load errors can be observed on the serial console (the Device Tree, firmware, and drivers have been modified).  The failures related to these messages do not appear to be fatal.

Standard poky Usage
-------------------
For information regarding environment setup and prerequisites for `poky`, please refer to the [Yocto Project Quick Start documentation](https://www.yoctoproject.org/docs/2.4.4/yocto-project-qs/yocto-project-qs.html)

Clone the `rocko` branch of `poky`:
```
git clone -b rocko git://git.yoctoproject.org/poky.git poky-rocko
cd poky-rocko
```

Clone the dependency meta layers:
```
git clone -b master git://github.com/OSSystems/meta-browser
git clone -b rocko git://git.openembedded.org/meta-openembedded
git clone -b rocko git://github.com/meta-qt5/meta-qt5
git clone -b rocko git://github.com/rockchip-linux/meta-rockchip
git clone -b rocko git://github.com/rockchip-linux/meta-rockchip-extra
git clone -b rocko git://github.com/meta-rust/meta-rust.git
git clone -b rocko git://github.com/csonsino/meta-rockpro64-hacks.git
```

Source the environment setup script to create the `build` directory
```
source oe-init-build-env
```

Edit `conf/bblayers.conf`, adding the layers from above (plus some extra `meta-openembedded` layers).  Add the following snippet, replacing `<poky-rocko>` with the path where `poky-rocko` was cloned:
```
BBLAYERS += " \
  <poky-rocko>/meta-openembedded/meta-oe \
  <poky-rocko>/meta-openembedded/meta-multimedia \
  <poky-rocko>/meta-openembedded/meta-networking \
  <poky-rocko>/meta-openembedded/meta-filesystems \
  <poky-rocko>/meta-openembedded/meta-python \
  <poky-rocko>/meta-browser \
  <poky-rocko>/meta-qt5 \
  <poky-rocko>/meta-rockchip \
  <poky-rocko>/meta-rockchip-extra \
  <poky-rocko>/meta-rust \
  <poky-rocko>/meta-rockpro64-hacks \
"
```

Edit conf/local.conf, setting the following values:
```
MACHINE ??= "rockpro64"
DISTRO ?= "rk-none"
```

Build an image:
```
bitbake rk-image-base
```

Rockchip poky Usage
-------------------
These instructions mostly follow the standard directions for setting up the environment (except for the slight `repo init` deviation).  See http://rockchip.wikidot.com/yocto-user-guide

Create the environment directory:
```
mkdir rk-yocto-bsp
cd rk-yocto-bsp
```

Clone the various repositories:
```
repo init --repo-branch=stable --repo-url=https://github.com/rockchip-linux/repo -u https://github.com/rockchip-linux/manifests -b yocto -m rocko.xml
repo sync
```

Clone the additional repositories:
```
cd sources
git clone -b rocko git://github.com/meta-rust/meta-rust.git
git clone -b rocko git://github.com/csonsino/meta-rockpro64-hacks.git
cd ..
```

Make sure that the prerequisite packages are installed:
```
sudo apt-get install gawk wget git-core diffstat unzip texinfo build-essential chrpath socat cpio python python3 pip3 pexpect libsdl1.2-dev xterm make xsltproc docbook-utils fop dblatex xmlto python-git pv
```

Initialize the environment:
```
MACHINE=rockpro64 DISTRO=rk-none . ./setup-environment -b build
```

Edit the `conf/bblayers.conf` file, adding the following snippet to the bottom of the file:
```
BBLAYERS += " \
  ${BSPDIR}/sources/meta-rust \
  ${BSPDIR}/sources/meta-rockpro64-hacks \
"
```

Build an image:
```
bitbake rk-image-base
```
