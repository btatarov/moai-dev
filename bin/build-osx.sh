#!/bin/bash

#
# Build script for Mac OSX
# Usage: Run from Moai SDK's root directory:
#
# build-osx-sdl.sh
#
# You can change the CMake options using -DOPTION=VALUE
# Check moai-dev/cmake/CMakeLists.txt for all the available options.
#
if [ x$1 == x ]; then
  libprefix=`dirname $0`/../lib/osx
else
  libprefix=$1
fi
mkdir -p $libprefix

libprefix=$(cd $libprefix; pwd)

cd `dirname $0`/..

moai_root=$(pwd)

# HACK: get fmod lib from Vavius' branch
mkdir -p $moai_root/3rdparty/fmod/lib/osx/
pushd $moai_root/3rdparty/fmod/lib/osx/
wget --quiet https://github.com/Vavius/moai-fmod-studio/raw/master/fmod/lib/osx/libfmod.dylib
popd

if ! [ -d "build" ]
then
mkdir build
fi
cd build

if ! [ -d "build-osx" ]
then
mkdir build-osx
fi
cd build-osx

set -e
cmake -G "Xcode" \
-DBUILD_OSX=TRUE \
-DMOAI_APPLE=TRUE \
-DMOAI_SDL=TRUE \
-DMOAI_HTTP_SERVER=TRUE \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$libprefix \
$moai_root/cmake/hosts/host-osx-sdl

set -o pipefail && cmake --build . --target install --config Release | xcpretty

if [ ! -e "$moai_root/util/moai" ]; then
   cp $libprefix/bin/moai $moai_root/util/moai
fi

if [ ! -e "$libprefix/bin/moai" ]; then
    exit 1
fi

exit 0
