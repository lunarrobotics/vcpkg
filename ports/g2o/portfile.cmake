vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO RainerKuemmerle/g2o
    REF 5b14535b8d63f837699d1dde27fd350fc6738b2a
    SHA512 8d8770e10c533c5c171c1e7a48d0a5b9528c2e0bb6100608fa6dcae9b0c2aa38e65f2f3a1ed683b57de11d7ee290443995919e97ec050dd02793e84c98127693
    HEAD_REF master
)

string(COMPARE EQUAL "${VCPKG_LIBRARY_LINKAGE}" "dynamic" BUILD_LGPL_SHARED_LIBS)

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DBUILD_LGPL_SHARED_LIBS=${BUILD_LGPL_SHARED_LIBS}
        -DG2O_BUILD_EXAMPLES=OFF
        -DG2O_BUILD_APPS=OFF
        -DG2O_USE_OPENGL=OFF
)

vcpkg_install_cmake()

vcpkg_copy_pdbs()

vcpkg_fixup_cmake_targets(CONFIG_PATH lib/cmake/g2o)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    file(GLOB_RECURSE HEADERS "${CURRENT_PACKAGES_DIR}/include/*")
    foreach(HEADER ${HEADERS})
        file(READ ${HEADER} HEADER_CONTENTS)
        string(REPLACE "#ifdef G2O_SHARED_LIBS" "#if 1" HEADER_CONTENTS "${HEADER_CONTENTS}")
        file(WRITE ${HEADER} "${HEADER_CONTENTS}")
    endforeach()
endif()

file(GLOB EXE ${CURRENT_PACKAGES_DIR}/bin/*.exe)
file(GLOB DEBUG_EXE ${CURRENT_PACKAGES_DIR}/debug/bin/*.exe)
if(EXE OR DEBUG_EXE)
    file(REMOVE ${EXE} ${DEBUG_EXE})
endif()
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)

file(INSTALL ${SOURCE_PATH}/doc/license-bsd.txt DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)
