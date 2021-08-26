vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/Livox-SDK
    REF 5dacfcf3ef38829338e51e997d897d3e7f730208
    SHA512 eddbe679df22e5c7327bffa460a1e7e403c7da1cd093348d016091fe271a918a0c2b3fffa6eacc10589a8bd308433a8eef769d0261b2ddde76c84cc8a86c2627
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DCMAKE_DEBUG_POSTFIX=_d
        -DUSE_SYSTEM_SPDLOG=1
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=1
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/livox_sdk TARGET_PATH share/livox_sdk TOOLS_PATH tools/livox_sdk)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
