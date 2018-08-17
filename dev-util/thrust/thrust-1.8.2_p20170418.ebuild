# Distributed under the terms of the GNU General Public License v2

EAPI=6

COMMIT_ID="417d78471dadefa3087ff274e64f43ce74acfd3d"
DESCRIPTION="Thrust is a parallel algorithms library which resembles the C++ Standard Template Library (STL)"
HOMEPAGE="https://github.com/thrust"
SRC_URI="https://github.com/thrust/thrust/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="*"
IUSE=""
S=${WORKDIR}/${PN}-${COMMIT_ID}
DEPEND=""
RDEPEND="${DEPEND} dev-util/nvidia-cuda-sdk"

src_install() {
        dodir /usr/include/${PN}
        insinto /usr/include/${PN}
        doins -r *
}
