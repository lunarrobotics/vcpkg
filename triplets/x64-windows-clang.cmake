set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE dynamic)
set(VCPKG_POLICY_SKIP_ARCHITECTURE_CHECK "enabled")
if(DEFINED VCPKG_PLATFORM_TOOLSET) 
# Silly trick to switch platform toolset to llvm while making sure vcpkg does what it normally does 
    set(VCPKG_PLATFORM_TOOLSET llvm)
endif()
set(ENV{CXX} "E:/tools/LLVM12/bin/clang-cl.exe") # for ninja
set(ENV{CC} "E:/tools/LLVM12/bin/clang-cl.exe")

