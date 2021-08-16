# header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/wrp_io
    REF f4801e3775d189792adaadde9578065f2f19d8f1
    SHA512 3714358318f6d59b7328acc9500af5894fedb8d84b3cb2bd87443e92e12737ca59dee785ca153d3c76ac85c457e613010c6e4f42168bb2ab49462ee51d1b675a
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=1
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/wrp_io)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
