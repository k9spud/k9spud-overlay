# Copyright 2021-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop qmake-utils xdg

DESCRIPTION="Qt GUI for browsing local Portage repositories"
HOMEPAGE="https://github.com/k9spud/appswipe"
SRC_URI="https://github.com/k9spud/appswipe/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${PN}-${PV}"

LICENSE="GPL-2"
SLOT="0"
IUSE="qt5 qt6"
KEYWORDS="~amd64 ~arm64"

DEPEND="qt5?
	(
		dev-qt/qtgui:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtwidgets:5
		dev-qt/qtsvg:5
	)
	!qt5?
	(
		dev-qt/qtbase:6
		dev-qt/qtsvg:6
	)"

PDEPEND="sys-apps/portage
	app-portage/portage-utils
	app-portage/gentoolkit
	dev-libs/glib
	lxde-base/lxterminal"

src_configure() {
    if use qt6 || !use qt5; then
	    eqmake6 AppSwipe.pro

	    cd backend || die
	    eqmake6 appswipebackend.pro

	    cd ../transport || die
	    eqmake6 appswipetransport.pro
    elif use qt5; then
	    eqmake5 AppSwipe.pro

	    cd backend || die
	    eqmake5 appswipebackend.pro

	    cd ../transport || die
	    eqmake5 appswipetransport.pro
    fi
}

src_compile() {
    emake -C ./
    emake -C backend/
    emake -C transport/
}

src_install() {
    mv AppSwipe appswipe
    dobin appswipe
    dobin backend/appswipebackend
    dobin transport/appswipetransport
    mv "${S}/img/appicon.svg" "${S}/img/appswipe.svg"
    doicon -s scalable "${S}/img/appswipe.svg"
    domenu ${PN}.desktop
}
