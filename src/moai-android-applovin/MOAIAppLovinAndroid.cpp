// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <moai-android/moaiext-jni.h>
#include <moai-android-applovin/MOAIAppLovinAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIAppLovinAndroid::_cacheRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAppLovinAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheRewardedVideo );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAppLovinAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAppLovinAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAppLovinAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAppLovinAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedRewardedVideo ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAppLovinAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAppLovinAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_Init );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAppLovinAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAppLovinAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAppLovinAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAppLovinAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowRewardedVideo );

	return 0;
}

//================================================================//
// MOAIAppLovinAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIAppLovinAndroid::MOAIAppLovinAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiAppLovin" );

	this->mJava_CacheRewardedVideo		= this->GetStaticMethod ( "cacheRewardedVideo", "()V" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	this->mJava_HasCachedRewardedVideo	= this->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "()V" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "()V" );
	this->mJava_ShowRewardedVideo		= this->GetStaticMethod ( "showRewardedVideo", "()V" );
}

//----------------------------------------------------------------//
MOAIAppLovinAndroid::~MOAIAppLovinAndroid () {
}

//----------------------------------------------------------------//
void MOAIAppLovinAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED",	( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIAppLovinAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIAppLovinAndroid > },
		{ "showInterstitial",			_showInterstitial },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// AppLovin JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiAppLovin_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiAppLovin_AKUInvokeListener\n" );
	MOAIAppLovinAndroid::Get ().InvokeListener ( ( u32 )eventID );
}
