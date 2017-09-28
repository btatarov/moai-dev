#!/usr/bin/env bash

echo "Setting up MoaiUtil path..."

UTIL_PATH=$(dirname "${BASH_SOURCE[0]}")
UTIL_PATH=$(cd $UTIL_PATH/../util; pwd)
export PATH=$PATH:$UTIL_PATH

echo "Push latest changes to OSX branch"
git remote add authorigin https://${GH_TOKEN}@github.com/btatarov/moai-sdk.git > /dev/null
git fetch origin travis-osx
git checkout travis-osx
git merge postmorph
git push origin
git push authorigin travis-osx
git checkout postmorph

echo "getting latest cmake"
pushd ~
wget http://www.cmake.org/files/v3.1/cmake-3.1.3-Linux-x86_64.tar.gz --no-check-certificate
tar xvf cmake-3.1.3-Linux-x86_64.tar.gz
cd cmake-3.1.3-Linux-x86_64/bin
export PATH=$(pwd):$PATH
popd


pushd `dirname $0`
bash build-linux.sh
echo Linux Build Successful
popd
