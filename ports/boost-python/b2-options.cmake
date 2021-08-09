set(BUILD_PYTHON_VERSIONS)

if("python2" IN_LIST FEATURES)
    # Find Python2 libraries. Can't use find_package here, but we already know where everything is
    file(GLOB VCPKG_PYTHON2_INCLUDE "${CURRENT_INSTALLED_DIR}/include/python2.*")
    set(VCPKG_PYTHON2_LIBS_RELEASE "${CURRENT_INSTALLED_DIR}/lib")
    set(VCPKG_PYTHON2_LIBS_DEBUG "${CURRENT_INSTALLED_DIR}/debug/lib")
    string(REGEX REPLACE ".*python([0-9\.]+).*" "\\1" VCPKG_PYTHON2_VERSION "${VCPKG_PYTHON2_INCLUDE}")
    list(APPEND BUILD_PYTHON_VERSIONS "${VCPKG_PYTHON2_VERSION}")
endif()
if ("${CMAKE_SYSTEM_PROCESSOR}" STREQUAL "aarch64" OR GNU)

    # Find Python3 libraries. Can't use find_package here, but we already know where everything is
    file(GLOB VCPKG_PYTHON3_INCLUDE "/usr/include/python3.*m")
    set(VCPKG_PYTHON3_LIBS_RELEASE "/usr/lib/aarch64-linux-gnu/lib")
    set(VCPKG_PYTHON3_LIBS_DEBUG "/usr/lib/aarch64-linux-gnu/lib")
    string(REGEX REPLACE ".*python([0-9\.]+).*" "\\1" VCPKG_PYTHON3_VERSION "${VCPKG_PYTHON3_INCLUDE}")
    list(APPEND BUILD_PYTHON_VERSIONS "${VCPKG_PYTHON3_VERSION}")

    string(REPLACE ";" "," BUILD_PYTHON_VERSIONS "${BUILD_PYTHON_VERSIONS}")
    string(REPLACE ";" ":" VCPKG_PYTHON3_INCLUDE "${VCPKG_PYTHON3_INCLUDE}")
    #set(BUILD_PYTHON_VERSIONS 3.6)
    message(STATUS "almaaa -  - ${BUILD_PYTHON_VERSIONS}")
else()
    # Find Python3 libraries. Can't use find_package here, but we already know where everything is
    file(GLOB VCPKG_PYTHON3_INCLUDE "${CURRENT_INSTALLED_DIR}/include/python3.*")
    set(VCPKG_PYTHON3_LIBS_RELEASE "${CURRENT_INSTALLED_DIR}/lib")
    set(VCPKG_PYTHON3_LIBS_DEBUG "${CURRENT_INSTALLED_DIR}/debug/lib")
    string(REGEX REPLACE ".*python([0-9\.]+).*" "\\1" VCPKG_PYTHON3_VERSION "${VCPKG_PYTHON3_INCLUDE}")
    list(APPEND BUILD_PYTHON_VERSIONS "${VCPKG_PYTHON3_VERSION}")

    string(REPLACE ";" "," BUILD_PYTHON_VERSIONS "${BUILD_PYTHON_VERSIONS}")

endif()

list(APPEND B2_OPTIONS
    python=${BUILD_PYTHON_VERSIONS}
    cxxflags="-fPIC"
)

if(VCPKG_CXX_FLAGS_DEBUG MATCHES "BOOST_DEBUG_PYTHON")
    list(APPEND B2_OPTIONS_DBG
        python-debugging=on
    )
endif()
