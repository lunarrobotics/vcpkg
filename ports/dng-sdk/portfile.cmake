
vcpkg_from_git(
    OUT_SOURCE_PATH SOURCE_PATH
    URL https://github.com/siposcsaba89/dng_sdk.git
    REF 5459f35d6d57bcacf7173a0bd08f14fc75bd2226
    PATCHES
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_SHARED_LIBS=0
        -DBUILD_EXAMPLES=1
        -DCMAKE_DEBUG_POSTFIX=_d
)

vcpkg_install_cmake()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/dng_sdk TARGET_PATH share/dng_sdk)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(COPY ${CMAKE_CURRENT_LIST_DIR}/usage DESTINATION ${CURRENT_PACKAGES_DIR}/share/dng_sdk)
file(INSTALL ${SOURCE_PATH}/license.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)

#file(MAKE_DIRECTORY ${CURRENT_PACKAGES_DIR}/tools/dng_sdk)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/bin/)
file(RENAME ${CURRENT_PACKAGES_DIR}/bin ${CURRENT_PACKAGES_DIR}/tools)

vcpkg_copy_pdbs()
