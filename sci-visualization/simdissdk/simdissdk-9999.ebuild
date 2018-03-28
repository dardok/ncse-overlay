EAPI=6

inherit cmake-utils

DESCRIPTION="An open source C++ framework providing functionality to create 3D scenes consisting of objects, whose position and state change with time, that are placed relative to a geographic map."
HOMEPAGE="https://simdis.nrl.navy.mil/"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/USNavalResearchLaboratory/simdissdk.git"
    EGIT_BRANCH="master"
else
    SRC_URI="https://github.com/USNavalResearchLaboratory/simdissdk/archive/${P}.tar.gz"
    S=${WORKDIR}/${PN}-${P}
fi

LICENSE="NRL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples +protobuf"

RDEPEND="
    >=dev-games/openscenegraph-3.5[osgapps]
    dev-db/sqlite:3
    protobuf? ( dev-libs/protobuf )
    >=sci-geosciences/osgearth-2.8[qt5]"

src_configure() {
    local mycmakeargs=(
        -DENABLE_CXX11_ABI=ON
        -DENABLE_QTDESIGNER_WIDGETS=OFF
        -DBUILD_SDK_EXAMPLES=$(usex examples)
    )

    cmake-utils_src_configure
}
