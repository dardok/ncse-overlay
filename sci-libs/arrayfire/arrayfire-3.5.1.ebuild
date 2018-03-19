EAPI=6
inherit cmake-utils

DESCRIPTION="ArrayFire is a high performance software library for parallel computing with an easy-to-use API."
HOMEPAGE="http://arrayfire.org"

if [[ ${PV} = *9999* ]]; then
    inherit git-r3
    EGIT_REPO_URI="https://github.com/arrayfire/arrayfire.git"
    EGIT_BRANCH="master"
else
    SRC_URI="http://arrayfire.com/arrayfire_source/arrayfire-full-${PV}.tar.bz2"
    S=${WORKDIR}/arrayfire-full-${PV}
fi

LICENSE="BSD-with-attribution"
SLOT="0"
KEYWORDS="amd64"

IUSE_CUDA_COMPUTES="
    cuda_compute_20
    +cuda_compute_30
    cuda_compute_32
    cuda_compute_35
    cuda_compute_37
    +cuda_compute_50
    cuda_compute_52
    cuda_compute_53
    cuda_compute_60
    cuda_compute_61
    cuda_compute_62
    cuda_compute_70"

IUSE="debug doc +unified +cpu cuda ${IUSE_CUDA_COMPUTES} lapack opencl examples graphics nonfree test"

REQUIRED_USE="cuda_compute_20? ( cuda )
    cuda_compute_30? ( cuda )
    cuda_compute_32? ( cuda )
    cuda_compute_35? ( cuda )
    cuda_compute_37? ( cuda )
    cuda_compute_50? ( cuda )
    cuda_compute_52? ( cuda )
    cuda_compute_53? ( cuda )
    cuda_compute_60? ( cuda )
    cuda_compute_61? ( cuda )
    cuda_compute_62? ( cuda )
    cuda_compute_70? ( cuda )
    cuda? ( || ( cuda_compute_20 cuda_compute_30 cuda_compute_32 cuda_compute_35 cuda_compute_37 cuda_compute_50 cuda_compute_52 cuda_compute_53 cuda_compute_60 cuda_compute_61 cuda_compute_62 cuda_compute_70 ) )"

RDEPEND="
    media-libs/freeimage
    lapack? ( virtual/lapack )
    cpu? (
        virtual/cblas
        sci-libs/fftw:3.0
    )
    graphics? (
        >=media-libs/glfw-3.1.4
        media-libs/fontconfig:1.0
    )
    cuda? ( >=dev-util/nvidia-cuda-toolkit-7.0 )
    opencl? (
        >=dev-libs/boost-1.48
        virtual/opencl
        sci-libs/clblast
    )
"

PATCHES=(
    "${FILESDIR}/cuda-9-cmake.patch"
)

src_configure() {
    COMPUTES_LIST=""
    if has cuda_compute_20 ${IUSE//+} ; then COMPUTES_LIST="20;$COMPUTES_LIST" ; fi
    if has cuda_compute_30 ${IUSE//+} ; then COMPUTES_LIST="30;$COMPUTES_LIST" ; fi
    if has cuda_compute_32 ${IUSE//+} ; then COMPUTES_LIST="32;$COMPUTES_LIST" ; fi
    if has cuda_compute_35 ${IUSE//+} ; then COMPUTES_LIST="35;$COMPUTES_LIST" ; fi
    if has cuda_compute_37 ${IUSE//+} ; then COMPUTES_LIST="37;$COMPUTES_LIST" ; fi
    if has cuda_compute_50 ${IUSE//+} ; then COMPUTES_LIST="50;$COMPUTES_LIST" ; fi
    if has cuda_compute_52 ${IUSE//+} ; then COMPUTES_LIST="52;$COMPUTES_LIST" ; fi
    if has cuda_compute_53 ${IUSE//+} ; then COMPUTES_LIST="53;$COMPUTES_LIST" ; fi
    if has cuda_compute_60 ${IUSE//+} ; then COMPUTES_LIST="60;$COMPUTES_LIST" ; fi
    if has cuda_compute_61 ${IUSE//+} ; then COMPUTES_LIST="61;$COMPUTES_LIST" ; fi
    if has cuda_compute_62 ${IUSE//+} ; then COMPUTES_LIST="62;$COMPUTES_LIST" ; fi
    if has cuda_compute_70 ${IUSE//+} ; then COMPUTES_LIST="70;$COMPUTES_LIST" ; fi

    local mycmakeargs=(
       -DBUILD_UNIFIED="$(usex unified)"
       -DBUILD_CPU="$(usex cpu)"
       -DBUILD_CUDA="$(usex cuda)"
       -DBUILD_OPENCL="$(usex opencl)"
       -DBUILD_GRAPHICS="$(usex graphics)"
       -DBUILD_NONFREE="$(usex nonfree)"
       -DBUILD_EXAMPLES="$(usex examples)"
       -DBUILD_TEST="$(usex test)"
       -DBUILD_DOCS="$(usex doc)"
       -DUSE_SYSTEM_CLBLAST=ON
       -DOPENCL_BLAS_LIBRARY=CLBlast
       -DCUDA_COMPUTE_DETECT=OFF
       -DCOMPUTES_DETECTED_LIST=$COMPUTES_LIST
    )

    cmake-utils_src_configure
}
