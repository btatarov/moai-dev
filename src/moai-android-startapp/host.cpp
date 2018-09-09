// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-startapp/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-startapp/MOAIStartAppAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidStartAppAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidStartAppAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidStartAppContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIStartAppAndroid );
}
