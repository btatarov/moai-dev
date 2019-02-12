#!/bin/bash

cd `dirname $0`/..
sdl_root=$(pwd)

rm -rf "$sdl_root/lib/linux"
rm -rf "$sdl_root/lib/build"

mkdir -p "$sdl_root/lib/linux"
mkdir -p "$sdl_root/lib/build"
cd $sdl_root/lib/build

<<<<<<< HEAD
<<<<<<< HEAD
bash ../../configure --prefix=$sdl_root/lib/build --disable-x11-shared --enable-sdl-dlopen
=======
sh ../../configure --prefix=$sdl_root/lib/build --disable-x11-shared --enable-sdl-dlopen
>>>>>>> postmorph
=======
sh ../../configure --prefix=$sdl_root/lib/build --disable-x11-shared --enable-sdl-dlopen
>>>>>>> postmorph
make
make install

cp $sdl_root/lib/build/lib/libSDL2*.so* $sdl_root/lib/linux/
