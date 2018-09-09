// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-vungle/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-vungle/MOAIVungleAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidVungleAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidVungleAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidVungleContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIVungleAndroid );

}
