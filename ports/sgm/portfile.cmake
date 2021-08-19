# header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO siposcsaba89/libSGM
    REF dfa4cfcc7851b854cb5d7b0629beb542bbf18086
    SHA512 d307b09533f1e58f58d24df2679792c73b387d1051f927f1f413029f0fe1617a1605e2441c76564fdbcaa5ccc935dbce6737323e20bfe3c59ad760fb22677a0e
    HEAD_REF master
)

set(AUTO_DETECT_ARCH ON)
set(CUDA_ARCH "-arch=sm_50")
#if cross compiling to nvidia agx
if(CMAKE_HOST_SYSTEM_NAME STREQUAL "Linux" AND VCPKG_TARGET_ARCHITECTURE STREQUAL "arm64")
    set(AUTO_DETECT_ARCH OFF)
    set(CUDA_ARCH "-arch=sm_72")
endif()
vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=1
        -DCMAKE_DEBUG_POSTFIX=_d
        -DAUTO_DETECT_ARCH=${AUTO_DETECT_ARCH}
        -DCUDA_ARCH=${CUDA_ARCH}
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/sgm)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
