// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-applovin/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-applovin/MOAIAppLovinAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidAppLovinAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidAppLovinAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidAppLovinContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIAppLovinAndroid );
}
