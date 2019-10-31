#!/usr/bin/env bash

set -e

GPS="google-play-services.jar"
PRF="com/google/android/gms"
LIB="google-play-services-stripped.jar"

rm -rf $LIB || true
rm -rf tmp || true
mkdir tmp
cp $GPS tmp/
cd tmp/

jar xvf $GPS > /dev/null
# rm -rf "$PRF/fitness"
# rm -rf "$PRF/maps"
# rm -rf "$PRF/nearby"
# rm -rf "$PRF/panorama"
# rm -rf "$PRF/appindexing"
# rm -rf "$PRF/appdatasearch"
rm -rf "$PRF/drive"  # good first choice - big and deprecated
# rm -rf "$PRF/cast"
# rm -rf "$PRF/tagmanager"
# rm -rf "$PRF/measurement"
# rm -rf "$PRF/vision"
# rm -rf "$PRF/wallet"
# rm -rf "$PRF/search"
# rm -rf "$PRF/wearable"

jar cf $LIB com/
mv $LIB ../

cd ..
rm -rf tmp/
