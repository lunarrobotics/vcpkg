vcpkg_fail_port_install(ON_TARGET "Windows" "OSX")

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/ntrip
    REF 1c0647676d6947c0ed93c9ff0638946f3463246d
    SHA512 acb45507e893eebb703430fe138b0d9480b16b2ee995e6bb9f39aa7d1cbc824b4764d0bd9b36079462508afcfe6af208d8754836955636dd3b2cd6d01ed4e1c5
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
