vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/openvslam
    REF b001c62ad62279b1c46f1c1c00f8e8a30ecc4c2f
    SHA512 4027cc81a6b4435c5c8edbe53776ae0f67ebf6f2732b30de10ce7559a30197ced36b19b5918ca73beb690ddde542db11aa51b1b760347ab6054cd2dfc8e0b5ae
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=1
        -DUSE_PANGOLIN_VIEWER=0
        -DUSE_SOCKET_PUBLISHER=0
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/openvslam)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
