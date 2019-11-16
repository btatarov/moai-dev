#!/bin/bash

#
# Build script for GNU/Linux
# Usage: Run from Moai SDK's root directory:
#
# build-linux.sh
#
# You can change the CMake options using -DOPTION=VALUE
# Check moai-dev/cmake/CMakeLists.txt for all the available options.
#
if [ -z $1 ]; then
  libprefix=`dirname $0`/../lib/linux
else
  libprefix=$1
fi

mkdir -p $libprefix

libprefix=$(cd $libprefix; pwd)

cd `dirname $0`/..

moai_root=$(pwd)

BUILD_DIR="build/build-linux"

if ! [ -d ${BUILD_DIR} ]; then
	mkdir -p $BUILD_DIR
fi

cd $BUILD_DIR

# - This fix, "curl: sed not found in PATH. Cannot continue without sed."
# - Shells problems: fish,
if ! [ -e PATH_SEPARATOR ]; then
	export PATH_SEPARATOR=:
fi

set -e

cmake \
-DBUILD_LINUX=TRUE \
-DMOAI_SDL=TRUE \
-DMOAI_HTTP_CLIENT=TRUE \
-DMOAI_HTTP_SERVER=TRUE \
-DMOAI_CRYPTO=TRUE \
-DMOAI_LIBCRYPTO=TRUE \
-DMOAI_FMOD_STUDIO=FALSE \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=$libprefix \
$moai_root/cmake/hosts/host-linux-sdl

cmake --build . --target install -- -j 4

cp $libprefix/bin/moai $moai_root/util/moai

if [ ! -e "$libprefix/bin/moai" ]; then
    exit 1
fi

exit 0
