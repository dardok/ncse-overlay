# Distributed under the terms of the GNU General Public License v2

EAPI="4"

inherit eutils flag-o-matic

THEMES_RELEASE=0.5.2

DESCRIPTION="Emerald Window Decorator"
HOMEPAGE="http://www.compiz.org/"
SRC_URI="http://releases.compiz.org/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="*"
IUSE=""

PDEPEND="~x11-themes/emerald-themes-${THEMES_RELEASE}"

RDEPEND="
	>=x11-libs/gtk+-2.8.0:2
	>=x11-libs/libwnck-2.14.2:1
	>=x11-wm/compiz-${PV}
"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.35
	virtual/pkgconfig
	>=sys-devel/gettext-0.15
"

DOCS=( AUTHORS ChangeLog INSTALL NEWS README TODO )

src_prepare() {
	# Fix pkg-config file pollution wrt #380197
	#epatch "${FILESDIR}"/${P}-pkgconfig-pollution.patch
	# fix build with gtk+-2.22 - bug 341143
	#sed -i -e '/#define G[DT]K_DISABLE_DEPRECATED/s:^://:' \
	#	include/emerald.h || die
	# Fix underlinking
	./autogen.sh
	append-libs -ldl -lm

	#epatch_user
}

src_configure() {
	econf --disable-mime-update || die "econf failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}

