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
IUSE="examples +protobuf"

RDEPEND="
    dev-db/sqlite:3
    protobuf? ( dev-libs/protobuf )
    >=dev-games/openscenegraph-3.5[osgapps]
    =sci-geosciences/osgearth-simdis-sdk-1.8[qt5]"

PATCHES=(
    "${FILESDIR}/sqlite-headers.patch"
)

src_configure() {
    local mycmakeargs=(
        -DENABLE_CXX11_ABI=ON
        -DENABLE_QTDESIGNER_WIDGETS=OFF
        -DBUILD_SDK_EXAMPLES=$(usex examples)
        -DOSG_LIBRARY_INCLUDE_PATH=/usr/include
        -DOSG_LIBRARY_RELEASE_NAME=/usr/lib/libosg.so
        -DOSG_PLUGIN_PATH=/usr/lib/osgPlugins-3.5.5
        -DOPENTHREADS_LIBRARY_RELEASE_NAME=/usr/lib/libOpenThreads.so
        -DOPENTHREADS_LIBRARY_INCLUDE_PATH=/usr/include
        -DOSGANIMATION_LIBRARY_RELEASE_NAME=/usr/lib/libosgAnimation.so
        -DOSGDB_LIBRARY_RELEASE_NAME=/usr/lib/libosgDB.so
        -DOSGFX_LIBRARY_RELEASE_NAME=/usr/lib/libosgFX.so
        -DOSGGA_LIBRARY_RELEASE_NAME=/usr/lib/libosgGA.so
        -DOSGMANIPULATOR_LIBRARY_RELEASE_NAME=/usr/lib/libosgManipulator.so
        -DOSGPARTICLE_LIBRARY_RELEASE_NAME=/usr/lib/libosgParticle.so
        -DOSGPRESENTATION_LIBRARY_RELEASE_NAME=/usr/lib/libosgPresentation.so
        -DOSGQT_LIBRARY_RELEASE_NAME=/usr/lib/libosgQt.so
        -DOSGQT_LIBRARY_INCLUDE_PATH=/usr/include
        -DOSGSHADOW_LIBRARY_RELEASE_NAME=/usr/lib/libosgShadow.so
        -DOSGSIM_LIBRARY_RELEASE_NAME=/usr/lib/libosgSim.so
        -DOSGTERRAIN_LIBRARY_RELEASE_NAME=/usr/lib/libosgTerrain.so
		-DOSGTEXT_LIBRARY_RELEASE_NAME=/usr/lib/libosgText.so
        -DOSGUTIL_LIBRARY_RELEASE_NAME=/usr/lib/libosgUtil.so
        -DOSGVIEWER_LIBRARY_RELEASE_NAME=/usr/lib/libosgViewer.so
        -DOSGVOLUME_LIBRARY_RELEASE_NAME=/usr/lib/libosgVolume.so
        -DOSGWIDGET_LIBRARY_RELEASE_NAME=/usr/lib/libosgWidget.so
        -DOSGEARTH_LIBRARY_INCLUDE_PATH=/usr/include
        -DOSGEARTH_LIBRARY_RELEASE_NAME=/usr/lib/libosgEarth.so
        -DOSGEARTH_ANNOTATION_LIBRARY_RELEASE_NAME=/usr/lib64/libosgEarthAnnotation.so
        -DOSGEARTH_FEATURES_LIBRARY_RELEASE_NAME=/usr/lib64/libosgEarthFeatures.so
        -DOSGEARTH_SPLAT_LIBRARY_RELEASE_NAME=/usr/lib64/libosgEarthSplat.so
        -DOSGEARTH_SYMBOLOGY_LIBRARY_RELEASE_NAME=/usr/lib64/libosgEarthSymbology.so
        -DOSGEARTH_UTIL_LIBRARY_RELEASE_NAME=/usr/lib64/libosgEarthUtil.so
        -DSQLITE3_LIBRARY_INCLUDE_PATH=/usr/include
        -DSQLITE3_LIBRARY_RELEASE_NAME=/usr/lib/libsqlite3.so
    )

    cmake-utils_src_configure
}
