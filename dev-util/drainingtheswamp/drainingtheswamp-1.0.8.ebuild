# Copyright 2021-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

MY_P="DrainingTheSwamp-${PV}"

inherit qmake-utils

DESCRIPTION="A tool for pipelining memory intensive builds on low memory computers."
HOMEPAGE="https://github.com/k9spud/DrainingTheSwamp"
SRC_URI="https://github.com/k9spud/DrainingTheSwamp/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm64"

DEPEND="dev-qt/qtcore
    sys-process/procps"

src_configure() {
    eqmake5 DrainingTheSwamp.pro
}

src_compile() {
    emake -C ./
}

src_install() {
    mv DrainingTheSwamp drainingtheswamp
    dobin drainingtheswamp
    dodoc README.md
}
