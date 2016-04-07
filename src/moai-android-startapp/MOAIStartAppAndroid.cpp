// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <moai-android/moaiext-jni.h>
#include <moai-android-startapp/MOAIStartAppAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_cacheInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_cacheRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheRewardedVideo );

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedRewardedVideo ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	jstring jappID = self->GetJString ( lua_tostring ( state, 1 ) );
	self->CallStaticVoidMethod ( self->mJava_Init, jappID );

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIStartAppAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowRewardedVideo );

	return 0;
}

//================================================================//
// MOAIStartAppAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIStartAppAndroid::MOAIStartAppAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiStartApp" );

	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "()V" );
	this->mJava_CacheRewardedVideo		= this->GetStaticMethod ( "cacheRewardedVideo", "()V" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	this->mJava_HasCachedRewardedVideo	= this->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "()V" );
	this->mJava_ShowRewardedVideo		= this->GetStaticMethod ( "showRewardedVideo", "()V" );
}

//----------------------------------------------------------------//
MOAIStartAppAndroid::~MOAIStartAppAndroid () {
}

//----------------------------------------------------------------//
void MOAIStartAppAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDEDVIDEOAD_COMPLETED",	( u32 )REWARDEDVIDEOAD_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIStartAppAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIStartAppAndroid > },
		{ "showInterstitial",			_showInterstitial },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// StartApp JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiStartApp_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiStartApp_AKUInvokeListener\n" );
	MOAIStartAppAndroid::Get ().InvokeListener ( ( u32 )eventID );
}
