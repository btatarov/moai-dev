#!/bin/bash

# Set variables
HOST_OS=`uname -s | tr "[:upper:]" "[:lower:]"`
MOAIROOT=/Users/bogdan/work/moai-sdk
NDK=/Users/bogdan/work/android-ndk-r15c
CFLAGS="-I $MOAIROOT/src -include zl-vfs/zl_replace.h "

# Prepare dirs
rm -rf lib/android/armeabi-v7a
rm -rf lib/android/x86
mkdir lib/android/armeabi-v7a
mkdir lib/android/x86

# Android/ARM, armeabi-v7a
NDKABI=15
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"
NDKARCH="-w -march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"
make clean
make -o2 HOST_CC="gcc -m32" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=Linux TARGET_FLAGS="$NDKF $NDKARCH" clean all

DESTDIR=lib/android/armeabi-v7a
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

# Android/x86, x86
NDKABI=15
NDKVER=$NDK/toolchains/x86-4.9
NDKP=$NDKVER/prebuilt/${HOST_OS}-x86_64/bin/i686-linux-android-
NDKF="-w --sysroot $NDK/platforms/android-$NDKABI/arch-x86"
make clean
make -o2 HOST_CC="gcc -m32" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=Linux TARGET_FLAGS="$NDKF" clean all

DESTDIR=lib/android/x86
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

make clean
