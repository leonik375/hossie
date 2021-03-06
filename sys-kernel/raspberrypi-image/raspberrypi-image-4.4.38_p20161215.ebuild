# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit versionator

DESCRIPTION="Raspberry PI kernel image"
HOMEPAGE="https://github.com/raspberrypi/firmware"

LICENSE="GPL-2 raspberrypi-videocore-bin"
SLOT="${PVR}"
KEYWORDS="~arm -*"

IUSE="rpi-b rpi-b-plus rpi-cm rpi-2-b rpi-3-b rpi-cm3"
REQUIRED_USE="|| ( $IUSE )"

MY_PV="1.$(get_version_component_range 4)"
MY_PV="${MY_PV//p}"
MY_KERNV="$(get_version_component_range 1-3)"
SRC_URI="https://github.com/raspberrypi/firmware/archive/${MY_PV}.tar.gz -> raspberrypi-firmware-${MY_PV}.tar.gz"

S="${WORKDIR}/firmware-${MY_PV}"

pkg_preinst() {
	if ! grep "${ROOT}boot" /proc/mounts >/dev/null 2>&1; then
		ewarn "${ROOT}boot is not mounted, the files might not be installed at the right place"
	fi
}

src_install() {
	if use rpi-b || use rpi-b-plus || use rpi-cm; then
		insinto /lib/modules
		doins -r "modules/${MY_KERNV}+"
		insinto /boot
		newins boot/kernel.img "kernel-${PVR}.img"
	fi
	if use rpi-2-b || use rpi-3-b || use rpi-cm3; then
		insinto /lib/modules
		doins -r "modules/${MY_KERNV}-v7+"
		insinto /boot
		newins boot/kernel7.img "kernel7-${PVR}.img"
	fi
}

pkg_postinst() {
	einfo "Note, this is just the kernel and modules"
	einfo "To boot, you also need sys-boot/raspberrypi-firmware"
}