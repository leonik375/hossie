# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools versionator

MY_VERSION="$(get_version_component_range 1-2)-$(get_version_component_range 3)"

DESCRIPTION="Webinterface for Nagios, Icinga, Shinken and Naemon"
HOMEPAGE="https://www.thruk.org/"
SRC_URI="https://download.thruk.org/pkg/v${MY_VERSION}/src/thruk-${MY_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql"

DEPEND="mysql? ( dev-perl/DBD-mysql )
	dev-perl/Class-Inspector
	dev-perl/Date-Manip
	dev-perl/Date-Calc
	dev-perl/DateTime
	dev-perl/File-Slurp
	dev-perl/GD
	dev-perl/IO-String
	dev-perl/JSON-XS
	dev-perl/libwww-perl
	dev-perl/Log-Dispatch
	dev-perl/Log-Log4perl
	dev-perl/Plack
	dev-perl/Template-Toolkit
	net-analyzer/nagios"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_VERSION}"

src_configure () {
	econf \
		--without-thruk-libs
}