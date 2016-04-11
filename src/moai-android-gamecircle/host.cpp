// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-android-gamecircle/host.h>
#include <moai-android/JniUtils.h>
#include <host-modules/aku_modules_android_config.h>
#include <moai-android-gamecircle/MOAIGameCircleAndroid.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUAndroidGameCircleAppFinalize () {
}

//----------------------------------------------------------------//
void AKUAndroidGameCircleAppInitialize () {
}

//----------------------------------------------------------------//
void AKUAndroidGameCircleContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIGameCircleAndroid );

}
