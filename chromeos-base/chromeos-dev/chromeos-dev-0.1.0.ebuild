# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

DESCRIPTION="Adds some developer niceties on top of Chrome OS for debugging"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="bluetooth opengl X"

# The dependencies here are meant to capture "all the packages
# developers want to use for development, test, or debug".  This
# category is meant to include all developer use cases, including
# software test and debug, performance tuning, hardware validation,
# and debugging failures running autotest.
#
# To protect developer images from changes in other ebuilds you
# should include any package with a user constituency, regardless of
# whether that package is included in the base Chromium OS image or
# any other ebuild.
#
# Don't include packages that are indirect dependencies: only
# include a package if a file *in that package* is expected to be
# useful.
RDEPEND="${RDEPEND}
	app-admin/sudo
	app-arch/gzip
	app-arch/tar
	app-benchmarks/punybench
	app-crypt/nss
	app-crypt/tpm-tools
	app-editors/vim
	app-misc/evtest
	app-shells/bash
	chromeos-base/chromeos-dev-init
	chromeos-base/flimflam-test
	chromeos-base/gmerge
	chromeos-base/protofiles
	chromeos-base/system_api
	dev-lang/python
	dev-python/dbus-python
	dev-util/hdctools
	dev-util/libc-bench
	dev-util/strace
	net-analyzer/netperf
	net-analyzer/tcpdump
	net-dialup/minicom
	net-misc/dhcp
	net-misc/iperf
	net-misc/iputils
	net-misc/openssh
	net-misc/rsync
	bluetooth? ( net-wireless/bluez-hcidump )
	net-wireless/iw
	net-wireless/wireless-tools
	sys-apps/coreutils
	sys-apps/diffutils
	sys-apps/file
	sys-apps/findutils
	sys-apps/i2c-tools
	sys-apps/kbd
	sys-apps/less
	sys-apps/smartmontools
	sys-apps/usbutils
	sys-apps/which
	sys-devel/gdb
	sys-fs/fuse
	sys-fs/lvm2
	sys-fs/sshfs-fuse
	sys-power/powertop
	sys-process/ktop
	sys-process/procps
	sys-process/psmisc
	sys-process/time
	virtual/perf
	virtual/chromeos-bsp-dev
	opengl? ( x11-apps/mesa-progs )
	x11-apps/mtplot
	x11-apps/xauth
	x11-apps/xdpyinfo
	x11-apps/xdriinfo
	x11-apps/xev
	x11-apps/xhost
	x11-apps/xinput
	x11-apps/xinput_calibrator
	x11-apps/xlsatoms
	x11-apps/xlsclients
	x11-apps/xmodmap
	x11-apps/xprop
	x11-apps/xrdb
	x11-apps/xset
	x11-apps/xtrace
	x11-apps/xwd
	x11-apps/xwininfo
	x11-misc/xdotool
	"

X86_DEPEND="
	app-benchmarks/i7z
	app-editors/qemacs
	sys-apps/dmidecode
	sys-apps/iotools
	sys-apps/pciutils
	x11-apps/intel-gpu-tools
"

RDEPEND="${RDEPEND} x86? ( ${X86_DEPEND} )"
RDEPEND="${RDEPEND} amd64? ( ${X86_DEPEND} )"
