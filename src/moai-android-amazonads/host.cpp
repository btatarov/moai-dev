// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-amazonads/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-amazonads/MOAIAmazonAdsAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidAmazonAdsAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidAmazonAdsAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidAmazonAdsContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIAmazonAdsAndroid );
}
