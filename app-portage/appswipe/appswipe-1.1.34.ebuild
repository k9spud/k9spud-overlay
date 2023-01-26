# Copyright 2021-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils

DESCRIPTION="Application for browsing your local Portage repository files"
HOMEPAGE="https://github.com/k9spud/appswipe"
SRC_URI="https://github.com/k9spud/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="dev-qt/qtgui
    dev-qt/qtsql[sqlite]
    dev-qt/qtwidgets"
PDEPEND="sys-apps/portage
	app-portage/portage-utils
	app-admin/sudo
	dev-libs/glib
	lxde-base/lxterminal"

src_configure() {
    eqmake5
}

src_install() {
    mv AppSwipe appswipe
    dobin appswipe
    mv "${S}/img/appicon.svg" "${S}/img/appswipe.svg"
    doicon -s scalable "${S}/img/appswipe.svg"
    domenu ${PN}.desktop
}
