#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/openvslam
    REF 4fbe7852ef10f64bd07e276bbd5e653a07784cae
    SHA512 d3f2bf7672aac9c99eee53d2e3e29be08111b30114197fbabdd11172a06f1d75c47f547feae5a02318d0fd65fcdb4f0bad21a2765b415c48f4051a73b136406d
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
