#vcpkg_check_linkage(ONLY_DYNAMIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/openvslam
    REF 2bd2f0c0e6cf5c675aa338d0764d3fba34bec8ea
    SHA512 5e96b5461e6926456525ac0cfd1fe808e2aab5cf7006931ca85adc694ec094bc50a579acb07ebea7a3780424f420389aa439dea70900738cc3f37a0d7b6ca12f
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
