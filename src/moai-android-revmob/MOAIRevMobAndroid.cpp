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

	jstring jplacementId = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial, jplacementId );

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_cacheRewardedVideo ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jstring jplacementId = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_CacheRewardedVideo, jplacementId );

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_hasCachedInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jstring jplacementId = self->GetJString ( lua_tostring ( state, 1 ) );

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial, jplacementId ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_hasCachedRewardedVideo ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jstring jplacementId = self->GetJString ( lua_tostring ( state, 1 ) );

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedRewardedVideo, jplacementId ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_init ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jstring jappID = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_Init, jappID );

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_showInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jstring jplacementId = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial, jplacementId );

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobAndroid::_showRewardedVideo ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIRevMobAndroid, "" )

	jstring jplacementId = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_ShowRewardedVideo, jplacementId );

	return 0;
}

//================================================================//
// MOAIRevMobAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIRevMobAndroid::MOAIRevMobAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiRevMob" );

	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "(Ljava/lang/String;)V" );
	this->mJava_CacheRewardedVideo		= this->GetStaticMethod ( "cacheRewardedVideo", "(Ljava/lang/String;)V" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "(Ljava/lang/String;)Z" );
	this->mJava_HasCachedRewardedVideo	= this->GetStaticMethod ( "hasCachedRewardedVideo", "(Ljava/lang/String;)Z" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "(Ljava/lang/String;)V" );
	this->mJava_ShowRewardedVideo		= this->GetStaticMethod ( "showRewardedVideo", "(Ljava/lang/String;)V" );
}

//----------------------------------------------------------------//
MOAIRevMobAndroid::~MOAIRevMobAndroid () {
}

//----------------------------------------------------------------//
void MOAIRevMobAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED",	( u32 )REWARDED_VIDEO_COMPLETED );

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
