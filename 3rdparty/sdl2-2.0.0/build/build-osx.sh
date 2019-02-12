#!/usr/bin/env bash

cd `dirname $0`/..
sdl_root=$(pwd)
echo "sdl root: $sdl_root"

rm -rf "$sdl_root/lib/osx"
rm -rf "$sdl_root/lib/build"

mkdir -p "$sdl_root/lib/osx"
mkdir -p "$sdl_root/lib/build"
cd $sdl_root/lib/build

CC=$sdl_root/build-scripts/gcc-fat.sh ../../configure --prefix=$sdl_root/lib/build --enable-sdl-dlopen
make
make install

cp $sdl_root/lib/build/lib/libSDL2.dylib $sdl_root/lib/osx/
