vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/openvslam
    REF 520d7c5e27d784381b61ed51f83c81b0e9473a41
    SHA512 0be7802f264c7f0a8d28d4a3105299158d35a199c172682f3d02fcfb8bcd10ee6be2ba696b22adbaec9fe99e098baeb7a1e998656e33402a8dfb186c874d1695
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
