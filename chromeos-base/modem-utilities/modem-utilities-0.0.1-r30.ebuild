# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2
CROS_WORKON_COMMIT="a11a495ee6460f66e64a9091cdaf6dd88ce18e9e"
CROS_WORKON_TREE="ca43c1f4b7bbe4516527e2a97306664ebdc89e8e"
CROS_WORKON_PROJECT="chromiumos/platform/modem-utilities"

inherit cros-debug cros-workon toolchain-funcs

DESCRIPTION="Chromium OS modem utilities"
HOMEPAGE="http://www.chromium.org/"
SRC_URI=""
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm x86"

RDEPEND="
	sys-apps/dbus
"

DEPEND="${RDEPEND}"

src_compile() {
	cros-debug-add-NDEBUG
	emake || die "Failed to compile"
}

src_install() {
	emake DESTDIR=${D} install || die "Install failed"
}
