// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-admob/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-admob/MOAIAdMobAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidAdMobAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidAdMobAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidAdMobContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIAdMobAndroid );
}
