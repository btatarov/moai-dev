#!/usr/bin/env bash

echo "Setting up MoaiUtil path..."

UTIL_PATH=$(dirname "${BASH_SOURCE[0]}")
UTIL_PATH=$(cd $UTIL_PATH/../util; pwd)
export PATH=$PATH:$UTIL_PATH

if [ x"${IS_TRAVIS_BUILD}" == xtrue ]; then
    echo "Push latest changes to OSX branch"
    git config --global user.email "travis-job@example.com"
    git config --global user.name "Travis Job"
    git fetch origin travis-osx:travis-osx
    git checkout travis-osx
    git merge postmorph
    git checkout HEAD -- .travis.yml
    git add . && git add -u
    git commit -m 'Get latest changes from postmorph branch'
    git push https://${GH_TOKEN}@github.com/btatarov/moai-sdk.git travis-osx:travis-osx > /dev/null
    git checkout postmorph
fi

echo "getting latest cmake"
pushd ~
wget http://www.cmake.org/files/v3.1/cmake-3.1.3-Linux-x86_64.tar.gz --no-check-certificate --quiet
tar xf cmake-3.1.3-Linux-x86_64.tar.gz
cd cmake-3.1.3-Linux-x86_64/bin
export PATH=$(pwd):$PATH
popd

echo "building sdl"
pushd `dirname $0`
cd ../3rdparty/sdl2-2.0.10
bash build/build-linux.sh
EXIT_CODE=$?
popd


pushd `dirname $0`
bash build-linux-untz.sh
EXIT_CODE=$?
popd

if [ "$EXIT_CODE" -gt 0 ]
then
    exit $EXIT_CODE
fi

echo Linux Build Successful
exit 0
