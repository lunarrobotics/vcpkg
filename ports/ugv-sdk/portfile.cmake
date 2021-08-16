# header-only library
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/ugv_sdk
    REF 1e1060641340a3449209954352635a5b26b427cc
    SHA512 b062525324fabfa07018a04dd69f7070d750673c9fde8f6791b1edbdc01bf18ad91afbc8ff6026d7021944fd47a0981886f84bf79f43598ac2123740a228be95
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_EXAMPLES=OFF
        -DBUILD_APPS=OFF
        -DBUILD_MONITOR=OFF
        -DCMAKE_WINDOWS_EXPORT_ALL_SYMBOLS=1
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/ugv_sdk TARGET_PATH share/ugv_sdk TOOLS_PATH tools/ugv_sdk)

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# Handle copyright
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
