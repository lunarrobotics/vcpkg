vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO faulhornlabs/DBoW2
    REF 7c2f85be79d52ff0571591f7fb3b12be32a3db94
    SHA512 c230e854576e839786bb1875b3aececd1e7e699516626798f9678d0085d4fd731c9fb9cfb654c0d766205d007b43bc915b2fedefdbbe6d1088ff29ffe291c1ce
    HEAD_REF master
)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA 
    OPTIONS -DBUILD_Demo=OFF -DCMAKE_DEBUG_POSTFIX=_d
    -DBUILD_SHARED_LIBS=0
    -DBUILD_UTILS=0
)

vcpkg_install_cmake()

# Move CMake files to the right place
vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/DBoW2)

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/include/DBoW2/DBoW2Config.cmake)

# Handle copyright
file(COPY ${SOURCE_PATH}/LICENSE.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT})
file(RENAME ${CURRENT_PACKAGES_DIR}/share/${PORT}/LICENSE.txt ${CURRENT_PACKAGES_DIR}/share/${PORT}/copyright)

