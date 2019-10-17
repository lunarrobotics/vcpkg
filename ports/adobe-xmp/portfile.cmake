include(vcpkg_common_functions)

vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/siposcsaba89/adobe_xmp.git
    REF d4e1b0b09c846ff69f4554299cdf326157abfd28
    PATCHES
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}/build
    PREFER_NINJA
    OPTIONS
        -DXMP_BUILD_STATIC=1
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/adobe-xmp)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/BSD-License.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})


vcpkg_copy_pdbs()
