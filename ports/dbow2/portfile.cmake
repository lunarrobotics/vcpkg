vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO siposcsaba89/DBoW2-1
    REF 2a354072d08e1c7de6dab162ae38863260d72251
    SHA512 8a602c7f0fd5393f11a10051256f656e9d8d34751cb2b42795897878a9f3d291bff0ea11145caed3ed852889253ab50349d4f27b6ed04b99de989315f80f206b
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

