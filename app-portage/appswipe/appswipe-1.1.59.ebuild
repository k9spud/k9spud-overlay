# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

DESCRIPTION="Qt GUI for browsing local Portage repositories"
HOMEPAGE="https://github.com/k9spud/appswipe"
SRC_URI="https://github.com/k9spud/appswipe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="dev-qt/qtgui
    dev-qt/qtsql[sqlite]
    dev-qt/qtwidgets
    dev-qt/qtsvg"
PDEPEND="sys-apps/portage
	app-portage/portage-utils
	app-portage/gentoolkit
	dev-libs/glib
	lxde-base/lxterminal"

src_configure() {
    eqmake5 AppSwipe.pro

    cd backend || die
    eqmake5 appswipebackend.pro
}

src_compile() {
    emake -C ./
    emake -C backend/
}

src_install() {
    mv AppSwipe appswipe
    dobin appswipe
    dobin backend/appswipebackend
    mv "${S}/img/appicon.svg" "${S}/img/appswipe.svg"
    doicon -s scalable "${S}/img/appswipe.svg"
    domenu ${PN}.desktop
}

