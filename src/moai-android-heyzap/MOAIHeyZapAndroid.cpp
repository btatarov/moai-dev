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

	jmethodID cacheInterstitial = self->GetStaticMethod ( "cacheInterstitial", "()V" );
	self->CallStaticVoidMethod ( cacheInterstitial );
	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_cacheRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jmethodID cacheRewardedVideo = self->GetStaticMethod ( "cacheRewardedVideo", "()V" );
	self->CallStaticVoidMethod ( cacheRewardedVideo );
	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jmethodID hasCachedInterstitial = self->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	state.Push ( self->CallStaticBooleanMethod ( hasCachedInterstitial ) );
	return 1;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jmethodID hasCachedRewardedVideo = self->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	state.Push ( self->CallStaticBooleanMethod ( hasCachedRewardedVideo ) );
	return 1;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jstring jpublisherID = self->GetJString ( state.GetValue < cc8* >( 1, 0 ));

	jmethodID init = self->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	self->CallStaticVoidMethod ( init, jpublisherID );
	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jmethodID showInterstitial = self->GetStaticMethod ( "showInterstitial", "()V" );
	self->CallStaticVoidMethod ( showInterstitial );
	return 0;
}

//----------------------------------------------------------------//
int MOAIHeyZapAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIHeyZapAndroid, "" )

	jmethodID showRewardedVideo = self->GetStaticMethod ( "showRewardedVideo", "()V" );
	self->CallStaticVoidMethod ( showRewardedVideo );
	return 0;
}

//================================================================//
// MOAIHeyZapAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIHeyZapAndroid::MOAIHeyZapAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiHeyZap" );
}

//----------------------------------------------------------------//
MOAIHeyZapAndroid::~MOAIHeyZapAndroid () {
}

//----------------------------------------------------------------//
void MOAIHeyZapAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDEDVIDEOAD_COMPLETED",	( u32 )REWARDEDVIDEOAD_COMPLETED );

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
