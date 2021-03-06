# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Chrome OS (meta package)"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE="bluetooth bootimage coreboot cros_ec gdmwimax X bootchart opengles"


################################################################################
#
# READ THIS BEFORE ADDING PACKAGES TO THIS EBUILD!
#
################################################################################
#
# Every chromeos dependency (along with its dependencies) is included in the
# release image -- more packages contribute to longer build times, a larger
# image, slower and bigger auto-updates, increased security risks, etc. Consider
# the following before adding a new package:
#
# 1. Does the package really need to be part of the release image?
#
# Some packages can be included only in the developer or test images, i.e., the
# chromeos-dev or chromeos-test ebuilds. If the package will eventually be used
# in the release but it's still under development, consider adding it to
# chromeos-dev initially until it's ready for production.
#
# 2. Why is the package a direct dependency of the chromeos ebuild?
#
# It makes sense for some packages to be included as a direct dependency of the
# chromeos ebuild but for most it doesn't. The package should be added as a
# direct dependency of the ebuilds for all packages that actually use it -- in
# time, this ensures correct builds and allows easier cleanup of obsolete
# packages. For example, if a utility will be invoked by the session manager,
# its package should be added as a dependency in the chromeos-login ebuild. Or
# if the package adds a daemon that will be started through an upstart job, it
# should be added as a dependency in the chromeos-init ebuild. If the package
# really needs to be a direct dependency of the chromeos ebuild, consider adding
# a comment why the package is needed and how it's used.
#
# 3. Are all default package features and dependent packages needed?
#
# The release image should include only packages and features that are needed in
# the production system. Often packages pull in features and additional packages
# that are never used. Review these and consider pruning them (e.g., through USE
# flags).
#
# 4. What is the impact on the image size?
#
# Before adding a package, evaluate the impact on the image size. If the package
# and its dependencies increase the image size significantly, consider
# alternative packages or approaches.
#
# 5. Is the package needed on all targets?
#
# If the package is needed only on some target boards, consider making it
# conditional through USE flags in the board overlays.
#
################################################################################

# XServer
RDEPEND="${RDEPEND}
	X? (
		chromeos-base/chromeos-chrome
		chromeos-base/chromeos-fonts
		chromeos-base/xorg-conf
		x11-apps/xinit
		x11-apps/xrandr
		x11-apps/xset-mini
		>=x11-base/xorg-server-1.6.3
	)
	"

X86_DEPEND="
		sys-boot/syslinux
"

RDEPEND="${RDEPEND} x86? ( ${X86_DEPEND} )"
RDEPEND="${RDEPEND} amd64? ( ${X86_DEPEND} )"

RDEPEND="${RDEPEND}
	arm? (
		chromeos-base/u-boot-scripts
	)
	"

RDEPEND="${RDEPEND}
	virtual/chromeos-bsp
	virtual/chromeos-firmware
	virtual/linux-sources
	"

# Specifically include the editor we want to appear in chromeos images, so that
# it is deterministic which editor is chosen by 'virtual/editor' dependencies
# (such as in the 'sudo' package).  See crosbug.com/5777.
RDEPEND="${RDEPEND}
	app-editors/vim
	"

# TODO(micahc): Remove board-devices from RDEPEND in lieu of
#               virtual/chromeos-bsp

# Note that o3d works with opengl on x86 and opengles on ARM, but not ARM
# opengl.

# We depend on dash for the /bin/sh shell for runtime speeds, but we also
# depend on bash to make the dev mode experience better.  We do not enable
# things like line editing in dash, so its interactive mode is very bare.
RDEPEND="${RDEPEND}
	app-admin/rsyslog
	app-arch/sharutils
	app-arch/tar
	bootchart? (
		app-benchmarks/bootchart
	)
	app-crypt/trousers
	app-i18n/ibus-english-m
	app-i18n/ibus-m17n
	app-i18n/ibus-mozc
	app-i18n/ibus-mozc-chewing
	app-i18n/ibus-mozc-hangul
	app-i18n/ibus-mozc-pinyin
	app-laptop/laptop-mode-tools
	app-shells/bash
	app-shells/dash
	chromeos-base/audioconfig
	chromeos-base/board-devices
	chromeos-base/bootstat
	chromeos-base/chromeos-assets
	chromeos-base/chromeos-assets-split
	chromeos-base/chromeos-auth-config
	chromeos-base/chromeos-base
	chromeos-base/chromeos-debugd
	chromeos-base/chromeos-imageburner
	chromeos-base/chromeos-init
	chromeos-base/chromeos-installer
	chromeos-base/chromeos-login
	chromeos-base/crash-reporter
	chromeos-base/cromo
	chromeos-base/cros-disks
	chromeos-base/cros_boot_mode
	chromeos-base/crosh
	chromeos-base/dev-install
	chromeos-base/inputcontrol
	chromeos-base/internal
	chromeos-base/metrics
	chromeos-base/mtpd
	chromeos-base/power_manager
	chromeos-base/root-certificates
	chromeos-base/shill
	chromeos-base/update_engine
	chromeos-base/userfeedback
	chromeos-base/vboot_reference
	chromeos-base/wimax_manager
	media-gfx/ply-image
	media-plugins/alsa-plugins
	!arm? ( media-plugins/o3d )
	arm? (
		opengles? ( media-plugins/o3d )
	)
	media-sound/alsa-utils
	media-sound/adhd
	net-firewall/iptables
	net-misc/tlsdate
	net-wireless/ath3k
	net-wireless/ath6k
	net-wireless/crda
	gdmwimax? (
		net-wireless/gdmwimax
	)
	net-wireless/marvell_sd8787
	bluetooth? (
		net-wireless/bluez
	)
	>=sys-apps/baselayout-2.0.0
	sys-apps/bootcache
	sys-apps/coreutils
	sys-apps/dbus
	sys-apps/eject
	sys-apps/flashrom
	sys-apps/grep
	sys-apps/mawk
	sys-apps/module-init-tools
	sys-apps/mosys
	sys-apps/net-tools
	sys-apps/pv
	sys-apps/rootdev
	sys-apps/sed
	sys-apps/shadow
	sys-apps/upstart
	sys-apps/ureadahead
	sys-apps/util-linux
	sys-auth/pam_pwdfile
	sys-fs/e2fsprogs
	sys-fs/udev
	sys-libs/timezone-data
	sys-process/lsof
	sys-process/procps
	virtual/modemmanager
	"

# TODO(dianders):
# In gentoo, the 'which' command is part of 'system'.  That means that packages
# assume that it's there and don't list it as an explicit dependency.  At the
# moment, we don't emerge 'system', but we really should at least emerge the
# embedded profile system.  Until then, we'll list it as a dependency here.
#
# Note that even gentoo's 'embedded' profile effectively has 'which' in its
# implicit dependencies, since it depepends on busybox and the default busybox
# config from gentoo provides which.
#
# See http://crosbug.com/8144
RDEPEND="${RDEPEND}
	coreboot? ( virtual/chromeos-coreboot )
	sys-apps/which
	"


# In addition to RDEPEND components, DEPEND in certain cases includes packages
# which do not need to be installed on the target, but need to be included for
# testing/compilation sanity check purposes.
DEPEND="${RDEPEND}
	bootimage? ( sys-boot/chromeos-bootimage )
	cros_ec? ( chromeos-base/chromeos-ec )
"

# Add dev-util/quipper to the image. This is needed to do
# profiling on ChromiumOS on live systems.
RDEPEND="${RDEPEND}
	dev-util/quipper
"

# USB / WiFi Firmware
RDEPEND="${RDEPEND}
	net-wireless/realtek-rt2800-firmware
"
