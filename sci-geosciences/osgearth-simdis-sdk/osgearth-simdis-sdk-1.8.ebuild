EAPI=6

inherit cmake-utils

DESCRIPTION="Dynamic map generation toolkit for OpenSceneGraph"
HOMEPAGE="http://osgearth.org/"

SRC_URI="https://github.com/gwaldron/osgearth/archive/${P}.tar.gz"
S=${WORKDIR}/osgearth-${P}

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug examples +fastdxt +protobuf leveldb rocksdb qt5 server"

RDEPEND="
    >=dev-games/openscenegraph-3.5[curl]
    dev-db/sqlite:3
    net-misc/curl
    sci-libs/gdal
    sci-libs/geos
    sys-libs/zlib[minizip]
    protobuf? ( dev-libs/protobuf )
    leveldb? ( dev-libs/leveldb )
    rocksdb? ( dev-libs/rocksdb )
    qt5? (
        dev-qt/qtcore:5
        dev-qt/qtgui:5
        dev-qt/qtopengl:5
        dev-qt/qtwidgets:5
        >=dev-games/openscenegraph-qt-3.5
    )
    server? ( dev-libs/poco[net,util] )"

src_configure() {
    local mycmakeargs=(
        -DWITH_EXTERNAL_TINYXML=OFF
        -DWITH_EXTERNAL_DUKTAPE=OFF
        -DOSGEARTH_QT_BUILD=$(usex qt5)
        -DOSGEARTH_ENABLE_FASTDXT=$(usex fastdxt)
    )

    cmake-utils_src_configure
}
