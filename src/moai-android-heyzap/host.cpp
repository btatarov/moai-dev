// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-heyzap/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-heyzap/MOAIHeyZapAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidHeyZapAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidHeyZapAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidHeyZapContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIHeyZapAndroid );
}
