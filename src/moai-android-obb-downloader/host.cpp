// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-obb-downloader/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-obb-downloader/MOAIObbDownloaderAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidObbDownloaderAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidObbDownloaderAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidObbDownloaderContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIObbDownloaderAndroid );
}
