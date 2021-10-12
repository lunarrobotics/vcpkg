vcpkg_fail_port_install(ON_TARGET "Windows" "OSX")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/ntrip
    REF d0d5a9d63f23c9f74b3b25f50264a133be41b510
    SHA512 1f22cd2b7d93154db20523bd84794bc9ecd1c5c0e4cf76f99654684c4912427870c3172b25ca8b8e1c1fa88dfdae1276a930612114bd247439724c2059bcd32b
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DNTRIP_BUILD_EXAMPLES=OFF
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=1
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/ntrip TARGET_PATH share/ntrip TOOLS_PATH tools/ntrip)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
