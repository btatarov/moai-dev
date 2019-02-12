#!/usr/bin/env bash

echo "Setting up MoaiUtil path..."

UTIL_PATH=$(dirname "${BASH_SOURCE[0]}")
UTIL_PATH=$(cd $UTIL_PATH/../util; pwd)
export PATH=$PATH:$UTIL_PATH

echo "getting MacOSX10.9.sdk"
wget --quiet https://github.com/phracker/MacOSX-SDKs/releases/download/10.13/MacOSX10.9.sdk.tar.xz
tar xf MacOSX10.9.sdk.tar.xz
sudo mv MacOSX10.9.sdk /Applications/Xcode-9.4.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs

echo "getting latest cmake"
pushd ~
wget --quiet http://www.cmake.org/files/v3.1/cmake-3.1.3-Darwin-x86_64.tar.gz
tar xf cmake-3.1.3-Darwin-x86_64.tar.gz
cd cmake-3.1.3-Darwin-x86_64/CMake.app/Contents/bin/
export PATH=$(pwd):$PATH
popd

echo "building sdl"
pushd `dirname $0`
cd ../3rdparty/sdl2-2.0.0/
./build/build-osx.sh
popd

pushd `dirname $0`
bash build-osx.sh
EXIT_CODE=$?
popd

if [ "$EXIT_CODE" -gt 0 ]
then
    exit $EXIT_CODE
fi

echo OSX Lib Build Successful
exit 0
