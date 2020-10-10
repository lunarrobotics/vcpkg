vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO siposcsaba89/DBoW2
    REF 4c9134b6e9011c6794be6dad25f40ec38300fe67
    SHA512 facd1cd6a0939137312820205d4142bf9a5fe072977190f18f9defddac92616f1a3752cf013f1e75f418a54d6c90eb933bf15a3ae6b0b9a08bb599fe21f8e253
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA 
    OPTIONS -DBUILD_Demo=OFF    
)

vcpkg_install_cmake()

# Move CMake files to the right place
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/DBoW2)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/DBoW2/DBoW2Config.cmake)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/${PORT}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright)

