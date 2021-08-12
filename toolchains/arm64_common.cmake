# CMake Toolchain file for crosscompiling on ARM.
#
# Target operating system name.
#set(CMAKE_SYSTEM_NAME Linux)
#set(CMAKE_SYSTEM_PROCESSOR aarch64)

# Name of C compiler.
#set(CMAKE_C_COMPILER "/usr/bin/aarch64-linux-gnu-gcc")
#set(CMAKE_CXX_COMPILER "/usr/bin/aarch64-linux-gnu-g++")

include(${CMAKE_CURRENT_LIST_DIR}/../scripts/toolchains/linux.cmake)
set(CMAKE_Fortran_COMPILER "/usr/bin/aarch64-linux-gnu-gfortran-7")

# Where to look for the target environment. (More paths can be added here)
set(CMAKE_FIND_ROOT_PATH /usr/aarch64-linux-gnu)
#set(CMAKE_SYSROOT /usr/aarch64-linux-gnu)

# Adjust the default behavior of the FIND_XXX() commands:
# search programs in the host environment only.
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)

# Search headers and libraries in the target environment only.
#set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
#set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

set(CPACK_DEBIAN_PACKAGE_ARCHITECTURE arm64)

set(CMAKE_CROSSCOMPILING_EMULATOR qemu-aarch64)
set(CMAKE_POSITION_INDEPENDENT_CODE 1)

# This assumes that pthread will be available on the target system
# (this emulates that the return of the TRY_RUN is a return code "0"
set(THREADS_PTHREAD_ARG "0"
  CACHE STRING "Result from TRY_RUN" FORCE)

# ros 2 variables
set(PYTHON_SOABI cpython-36m-aarch64-linux-gnu)

# This set the target for 'nvcc' that used by CUDA_TOOLKIT
#set(CUDA_TARGET_CPU_ARCH ${CMAKE_SYSTEM_PROCESSOR})
set(CUDA_TARGET_OS_VARIANT "linux")
set(cuda_target_full_path ${CMAKE_SYSTEM_PROCESSOR}-${CUDA_TARGET_OS_VARIANT})
set(CUDA_TOOLKIT_ROOT_DIR $ENV{CUDA_TOOLKIT_ROOT_DIR})
set(CUDA_TOOLKIT_INCLUDE ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/include)
set(CUDA_INCLUDE_DIRS ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/include)
set(CUDA_CUDART_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/libcudart.so)
set(CUDA_CUDA_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libcuda.so)
set(CUDA_cublas_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libcublas.so)
set(CUDA_cufft_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libcufft.so)
set(CUDA_nppc_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppc.so)
set(CUDA_nppial_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppial.so)
set(CUDA_nppicc_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppicc.so)
set(CUDA_nppicom_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppicom.so)
set(CUDA_nppidei_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppidei.so)
set(CUDA_nppif_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppif.so)
set(CUDA_nppig_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppig.so)
set(CUDA_nppim_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppim.so)
set(CUDA_nppist_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppist.so)
set(CUDA_nppisu_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppisu.so)
set(CUDA_nppitc_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnppitc.so)
set(CUDA_npps_LIBRARY ${CUDA_TOOLKIT_ROOT_DIR}/targets/${cuda_target_full_path}/lib/stubs/libnpps.so)
set(CMAKE_CUDA_COMPILER ${CUDA_TOOLKIT_ROOT_DIR}/bin/nvcc)
set(CMAKE_CUDA_HOST_COMPILER ${CMAKE_CXX_COMPILER})
#for fastrtps ros
set(Asio_INCLUDE_DIR ${CMAKE_CURRENT_LIST_DIR}/../installed/${VCPKG_TARGET_TRIPLET}/include/)

# load vcpkg toolchain
message(STATUS "Loading vcpkg toolchain: ${CMAKE_CURRENT_LIST_DIR}/../scripts/buildsystems/vcpkg.cmake")
if (NOT DEFINED VCPKG_CHAINLOAD_TOOLCHAIN_FILE) # handle recursion
	include(${CMAKE_CURRENT_LIST_DIR}/../scripts/buildsystems/vcpkg.cmake)
endif()
