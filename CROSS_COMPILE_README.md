# Packages

```
//TODO
./vcpkg install opencv[contrib,dnn,ffmpeg,jpeg,png,tiff,webp]:arm64-linux-cross
./vcpkg install dbow2:arm64-linux-cross

```

# Set up pkgconfig to find target libraries

```
export PKG_CONFIG_PATH=/usr/lib/aarch64-linux-gnu/pkgconfig/
export PKG_CONFIG_LIBDIR=/usr/lib/aarch64-linux-gnu/
```

# CMake project configure for cross compile

```
cmake .. -DVCPKG_CHAINLOAD_TOOLCHAIN_FILE=/home/csaba/projects/vcpkg/toolchains/arm64.cmake \
    -DCMAKE_PREFIX_PATH=/home/csaba/projects/vcpkg/installed/arm64-linux-cross/ \
    -DCMAKE_TOOLCHAIN_FILE=/home/csaba/projects/vcpkg/scripts/buildsystems/vcpkg.cmake \
    -DVCPKG_TARGET_TRIPLET=arm64-linux-cross
```

# Build ros2 with cross compiled vcpkg deps

```
colcon build --merge-install \
    --install-base ros2_galactic \
    --cmake-force-configure \
    --cmake-args \
    -DCMAKE_BUILD_TYPE=Release \
    -DVCPKG_TARGET_TRIPLET=arm64-linux-cross \
    -DCMAKE_TOOLCHAIN_FILE:FILEPATH=<VCPKG_ROOT>/toolchains/arm64.cmake \
    -DCMAKE_PREFIX_PATH=<VCPKG_ROOT>/installed/arm64-linux-cross/ \
    -DAsio_INCLUDE_DIR=<VCPKG_ROOT>/installed/arm64-linux-cross/include/
```

# FAQ
https://vcpkg.readthedocs.io/en/latest/about/faq/#can-i-use-my-own-cmake-toolchain-file-with-vcpkgs-toolchain-file