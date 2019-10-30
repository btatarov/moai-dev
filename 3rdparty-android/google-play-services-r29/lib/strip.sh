#!/usr/bin/env bash

set -e

GPS="google-play-services.in"
PRF="com/google/android/gms"

#rm -rf tmp/
#mkdir tmp
cp $GPS tmp/
cd tmp/

jar xvf $GPS > /dev/null
rm -rf "$PRF/fitness"
rm -rf "$PRF/maps"
rm -rf "$PRF/nearby"
rm -rf "$PRF/panorama"
rm -rf "$PRF/appindexing"
rm -rf "$PRF/appdatasearch"
rm -rf "$PRF/drive"
rm -rf "$PRF/cast"
rm -rf "$PRF/tagmanager"
rm -rf "$PRF/measurement"
rm -rf "$PRF/vision"
rm -rf "$PRF/wallet"
rm -rf "$PRF/search"
rm -rf "$PRF/wearable"
jar cf google-play-services-stripped.jar com/
mv google-play-services-stripped.jar ../

cd ..
#rm -rf tmp/
