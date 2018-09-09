#!/bin/bash
set -e

# check for command line switches
usage="usage: $0 [--clean]"

while [ $# -gt 0 ];	do
    case "$1" in
		--clean)  clean=true; break;;
		*)
	    	echo >&2 \
	    		$usage
	    	exit 1;;
    esac
    shift
done

if [ x"$clean" == xtrue ]; then

  xcodebuild -configuration Release -project libmoai.xcodeproj -target libmoai-ios-all -sdk iphonesimulator clean || exit 1
	xcodebuild -configuration Release -project libmoai.xcodeproj -target libmoai-ios-all -sdk iphoneos clean || exit 1
fi

xcodebuild -configuration Release -project libmoai.xcodeproj -target libmoai-ios-all -sdk iphonesimulator || exit 1
xcodebuild -configuration Release -project libmoai.xcodeproj -target libmoai-ios-all -sdk iphoneos || exit 1

pushd ./build/Release-iphoneos/ > /dev/null
rm -rf "../Release-universal" # clean out the old dir (if any)
mkdir -p "../Release-universal" # make the new dir
for f in *.a
do
	echo $f
	libs="$f ../Release-iphonesimulator/$f"

	if ! xcrun lipo -create -output "../Release-universal/$f" $libs; then
		echo >&2 "lipo failed, giving up."
		exit 1
	fi
done
popd > /dev/null

IOS_LIB=../../lib/ios

rm -rf $IOS_LIB
mkdir -p $IOS_LIB
cp -a ./build/Release-universal/*.a $IOS_LIB
cp -a ../../3rdparty/fmod/lib/ios/*.a $IOS_LIB
