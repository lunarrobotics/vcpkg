vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/socket.io-client-cpp
    REF 6b102024c54df0369c1c6d38bb9c8cc63bb98ff4
    SHA512 0716b7585e04530e5578f51d07aa75e5ee8cfbad8e357f2778b7aab9a7af407351f055dc9f186dbfa6463fd462a813f78bbc4319964ecba033ad5025d4450816
    HEAD_REF master
#    PATCHES
#        fix-file-not-found.patch
#        fix-error-C3321.patch
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_UNIT_TESTS=0
)

vcpkg_install_cmake()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
