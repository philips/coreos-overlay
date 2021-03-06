#
# Copyright (c) 2011 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2
# $Header:$
#

EAPI=2
EGIT_REPO_SERVER="https://bitbucket.org"
EGIT_REPO_URI="${EGIT_REPO_SERVER}/coreos/etcd-lib.git"
EGIT_BRANCHEGIT_BRANCH="master"

inherit git systemd

DESCRIPTION="Experiments in using etcd"
HOMEPAGE="https://bitbucket.org/coreos/etcd-libs"
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm x86"
IUSE=""

# TODO, use cros
#CROS_WORKON_PROJECT="coreos/etcd-libs"
#CROS_WORKON_LOCALNAME="etcd-libs"
#CROS_WORKON_REPO="https://bitbucket.org"
#inherit toolchain-funcs cros-workon systemd


src_install() {
	systemd_dounit "${S}"/etcd@.service
	dodir /usr/lib/etcd/
	insinto /usr/lib/etcd/
	cp -Ra "${S}"/* ${D}/usr/lib/etcd/

	dodir /var/lib/containers
	dodir /var/lib/systemd-rest
}
