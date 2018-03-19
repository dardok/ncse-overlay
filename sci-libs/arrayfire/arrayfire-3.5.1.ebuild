EAPI=5
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
IUSE="debug +unified +cpu cuda opencl examples graphics nonfree test"

RDEPEND="
    media-libs/freeimage
    cpu? (
        virtual/cblas
        sci-libs/fftw:3.0
    )
    graphics? (
        >=media-libs/glfw-3.1.4
        media-libs/fontconfig:1.0
    )
    cuda? ( >=dev-util/nvidia-cuda-toolkit-8.0 )
    opencl? (
        >=dev-libs/boost-1.48
        virtual/opencl
        sci-libs/clblast
    )
"

PATCHES=(
    "${FILESDIR}/cuda-9-cmake.patch"
)

src_prepare() {
    epatch "${PATCHES[@]}"
}

src_configure() {
    local mycmakeargs=(
       $(cmake-utils_use_build unified UNIFIED)
       $(cmake-utils_use_build cpu CPU)
       $(cmake-utils_use_build cuda CUDA)
       $(cmake-utils_use_build opencl OPENCL)
       $(cmake-utils_use_build graphics GRAPHICS)
       $(cmake-utils_use_build nonfree NONFREE)
       $(cmake-utils_use_build examples EXAMPLES)
       $(cmake-utils_use_build test TEST)
       -DUSE_SYSTEM_CLBLAST=ON
       -DOPENCL_BLAS_LIBRARY=CLBlast
    )

    cmake-utils_src_configure
}
