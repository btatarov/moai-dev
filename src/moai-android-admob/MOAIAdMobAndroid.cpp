// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-admob/MOAIAdMobAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_cacheInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	jstring junitID = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_Init, junitID );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial );

	return 0;
}

//================================================================//
// MOAIAdMobAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIAdMobAndroid::MOAIAdMobAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiAdMob" );

	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "()V" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "()V" );
}

//----------------------------------------------------------------//
MOAIAdMobAndroid::~MOAIAdMobAndroid () {
}

//----------------------------------------------------------------//
void MOAIAdMobAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "INTERSTITIAL_LOAD_FAILED",	( u32 )INTERSTITIAL_LOAD_FAILED );
	state.SetField ( -1, "INTERSTITIAL_DISMISSED", 		( u32 )INTERSTITIAL_DISMISSED );

	luaL_Reg regTable [] = {
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIAdMobAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIAdMobAndroid > },
		{ "showInterstitial",			_showInterstitial },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// AdMob JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiAdMob_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiAdMob_AKUInvokeListener\n" );
	MOAIAdMobAndroid::Get ().InvokeListener (( u32 )eventID );
}
