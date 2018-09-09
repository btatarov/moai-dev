// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <moai-android/moaiext-jni.h>
#include <moai-android-heyzap/MOAIHeyZapAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_cacheInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_cacheRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheRewardedVideo );

	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedRewardedVideo ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jstring jpublisherID = self->GetJString ( lua_tostring ( state, 1 ) );
	bool amazon_store = lua_toboolean ( state, 2 );

	self->CallStaticVoidMethod ( self->mJava_Init, jpublisherID, amazon_store );

	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowRewardedVideo );

	return 0;
}

//================================================================//
// MOAIHeyZapAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIHeyZapAndroid::MOAIHeyZapAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiHeyZap" );

	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "()V" );
	this->mJava_CacheRewardedVideo		= this->GetStaticMethod ( "cacheRewardedVideo", "()V" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	this->mJava_HasCachedRewardedVideo	= this->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;Z)V" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "()V" );
	this->mJava_ShowRewardedVideo		= this->GetStaticMethod ( "showRewardedVideo", "()V" );
}

//----------------------------------------------------------------//
MOAIHeyZapAndroid::~MOAIHeyZapAndroid () {
}

//----------------------------------------------------------------//
void MOAIHeyZapAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED",	( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIHeyZapAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIHeyZapAndroid > },
		{ "showInterstitial",			_showInterstitial },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// HeyZap JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiHeyZap_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiHeyZap_AKUInvokeListener\n" );
	MOAIHeyZapAndroid::Get ().InvokeListener ( ( u32 )eventID );
}
