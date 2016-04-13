#!/bin/bash
set -e

ios_targets=(
    "libmoai-ios"
    "libmoai-ios-3rdparty-core"
    "libmoai-ios-3rdparty-crypto"
    "libmoai-ios-adcolony"
    "libmoai-ios-audio-sampler"
    "libmoai-ios-billing"
    "libmoai-ios-box2d"
    "libmoai-ios-chartboost"
    "libmoai-ios-crittercism"
    "libmoai-ios-crypto"
    "libmoai-ios-facebook"
    "libmoai-ios-fmod-studio"
    "libmoai-ios-gamecenter"
    "libmoai-ios-http-client"
    "libmoai-ios-http-server"
    "libmoai-ios-luaext"
    "libmoai-ios-sim"
    "libmoai-ios-spine"
    "libmoai-ios-untz"
    "libmoai-ios-vungle"
    "libmoai-ios-zl-core"
    "libmoai-ios-zl-crypto"
    "libmoai-ios-zl-vfs"
)
ios_sdks=( "iphoneos" "iphonesimulator" )

usage="usage: $0 [-c Debug|Release|all]"
configurations="all"
while [ $# -gt 0 ];	do
    case "$1" in
		-c)  configurations="$2"; shift;;
		-*)
	    	echo >&2 \
	    		$usage
	    	exit 1;;
		*)  break;;
    esac
    shift
done

if [ x"$configurations" != xDebug ] && [ x"$configurations" != xRelease ] && [ x"$configurations" != xall ]; then
	echo $usage
	exit 1
elif [ x"$configurations" = xall ]; then
	configurations="Debug Release"
fi

targets="${ios_targets[@]}"
sdks="${ios_sdks[@]}"

for config in $configurations; do
	for sdk in $sdks; do
		for target in $targets; do
			echo "Cleaning libmoai/$target/$sdk for $config"
			xcodebuild -configuration $config -project libmoai.xcodeproj -target $target -sdk $sdk clean
			echo "Done"
		done
	done
done
