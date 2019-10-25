#!/bin/bash

# Set variables
HOST_OS=`uname -s | tr "[:upper:]" "[:lower:]"`
MOAIROOT=/Users/bogdan/work/moai-sdk
NDK=/Users/bogdan/work/android-ndk-r15c
CFLAGS="-I $MOAIROOT/src -include zl-vfs/zl_replace.h "

# Prepare dirs
rm -rf lib/android/arm64-v8a
rm -rf lib/android/x86_64
mkdir lib/android/arm64-v8a
mkdir lib/android/x86_64

# Android/ARM64, arm64-v8a
NDKABI=21
NDKVER=$NDK/toolchains/aarch64-linux-android-4.9
NDKP=$NDKVER/prebuilt/${HOST_OS}-x86_64/bin/aarch64-linux-android-
NDKARCH="-w -DLJ_ABI_SOFTFP=0 -DLJ_ARCH_HASFPU=1 -DLUAJIT_ENABLE_GC64=1"
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm64"
make clean
make -o2 HOST_CC="gcc -m64" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" clean all

DESTDIR=lib/android/arm64-v8a
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

# Android/x86_64, x86_64
NDKABI=21
NDKVER=$NDK/toolchains/x86_64-4.9
NDKP=$NDKVER/prebuilt/${HOST_OS}-x86_64/bin/x86_64-linux-android-
NDKARCH="-w -DLUAJIT_ENABLE_GC64=1"
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-x86_64"
make clean
make -o2 HOST_CC="gcc -m64" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" clean all

DESTDIR=lib/android/x86_64
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

make clean
