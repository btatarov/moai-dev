#!/bin/bash

# Set variables
HOST_OS=`uname -s | tr "[:upper:]" "[:lower:]"`

MOAIROOT=/Users/bogdan/work/moai
NDK=/Users/bogdan/work/android-sdk/android-ndk-r11
NDKABI=9
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKP=$NDKVER/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-arm"
CFLAGS="-I $MOAIROOT/src -include zlcore/zl_replace.h "

# Prepare dirs
rm -rf libs/android/
mkdir -p libs/android/armeabi
mkdir libs/android/armeabi-v7a
mkdir libs/android/x86

# Android/ARM, armeabi (ARMv5TE soft-float), Android 2.2+ (Froyo)
make clean
make -o2 HOST_CC="gcc -m32" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=android TARGET_FLAGS="$NDKF" clean all

DESTDIR=libs/android/armeabi
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

# Android/ARM, armeabi-v7a (ARMv7 VFP), Android 4.0+ (ICS)
NDKABI=14
NDKVER=$NDK/toolchains/arm-linux-androideabi-4.9
NDKARCH="-march=armv7-a -mfloat-abi=softfp -Wl,--fix-cortex-a8"
make clean
make -o2 HOST_CC="gcc -m32" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=android TARGET_FLAGS="$NDKF $NDKARCH" clean all

DESTDIR=libs/android/armeabi-v7a
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

# Android/x86, x86 (i686 SSE3), Android 4.0+ (ICS)
NDKABI=14
NDKVER=$NDK/toolchains/x86-4.9
NDKP=$NDKVER/prebuilt/${HOST_OS}-x86_64/bin/i686-linux-android-
NDKF="--sysroot $NDK/platforms/android-$NDKABI/arch-x86"
make clean
make -o2 HOST_CC="gcc -m32" CROSS=$NDKP TARGET_CONLY_FLAGS="$CFLAGS" TARGET_SYS=android TARGET_FLAGS="$NDKF" clean all

DESTDIR=libs/android/x86
if [ -f src/libluajit.a ]; then
    mv src/libluajit.a $DESTDIR/libluajit.a
fi;

make clean
