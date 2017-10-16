# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-utils toolchain-funcs

DESCRIPTION="Cloud music integration for your desktop"
HOMEPAGE="https://colinduquesnoy.github.io/MellowPlayer"
SRC_URI="https://github.com/ColinDuquesnoy/MellowPlayer/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-qt/qtquickcontrols2-5.9:5
	>=dev-qt/qtwebengine-5.9:5[-bindist,widgets]"
DEPEND="${RDEPEND}
	dev-util/cmake
	>=sys-devel/gcc-6.0"

S="${WORKDIR}/MellowPlayer-${PV}"

src_configure() {
	if tc-is-gcc; then
		if [ $(gcc-major-version) -lt 6 ]; then
			eerror "You need at least GCC 6.0 set to your active compiler" && die
		fi
	fi

	default
}