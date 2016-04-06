// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <moai-android/moaiext-jni.h>
#include <moai-android-revmob/MOAIRevMobAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_cacheInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID cacheInterstitial = self->GetStaticMethod ( "cacheInterstitial", "()V" );
	self->CallStaticVoidMethod ( cacheInterstitial );
	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_cacheRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID cacheRewardedVideo = self->GetStaticMethod ( "cacheRewardedVideo", "()V" );
	self->CallStaticVoidMethod ( cacheRewardedVideo );
	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID hasCachedInterstitial = self->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	state.Push ( self->CallStaticBooleanMethod ( hasCachedInterstitial ) );
	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID hasCachedRewardedVideo = self->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	state.Push ( self->CallStaticBooleanMethod ( hasCachedRewardedVideo ) );
	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID init = self->GetStaticMethod ( "init", "()V" );
	self->CallStaticVoidMethod ( init );
	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID showInterstitial = self->GetStaticMethod ( "showInterstitial", "()V" );
	self->CallStaticVoidMethod ( showInterstitial );
	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jmethodID showRewardedVideo = self->GetStaticMethod ( "showRewardedVideo", "()V" );
	self->CallStaticVoidMethod ( showRewardedVideo );
	return 0;
}

//================================================================//
// MOAIRevMobAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIRevMobAndroid::MOAIRevMobAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiRevMob" );
}

//----------------------------------------------------------------//
MOAIRevMobAndroid::~MOAIRevMobAndroid () {
}

//----------------------------------------------------------------//
void MOAIRevMobAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDEDVIDEOAD_COMPLETED",	( u32 )REWARDEDVIDEOAD_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIRevMobAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIRevMobAndroid > },
		{ "showInterstitial",			_showInterstitial },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// RevMob JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiRevMob_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiRevMob_AKUInvokeListener\n" );
	MOAIRevMobAndroid::Get ().InvokeListener ( ( u32 )eventID );
}
