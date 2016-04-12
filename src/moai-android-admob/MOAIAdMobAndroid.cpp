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
int MOAIAdMobAndroid::_cacheBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheBanner );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_cacheInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_hasCachedBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedBanner ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_hasCachedInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_hideBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_HideBanner );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_init ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	jstring junitID = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_Init, junitID );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_initBannerWithParams ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	jstring 	junitID 	= self->GetJString ( lua_tostring ( state, 1 ) );
	u32			width 		= lua_tonumber ( state, 2 );
	u32			height 		= lua_tonumber ( state, 3 );
	u32			margin 		= lua_tonumber ( state, 4 );
	bool		bottom 		= lua_toboolean ( state, 5 );

	self->CallStaticVoidMethod ( self->mJava_InitBannerWithParams, junitID, width, height, margin, bottom );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobAndroid::_showBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAdMobAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowBanner );

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

	this->mJava_CacheBanner				= this->GetStaticMethod ( "cacheBanner", "()V" );
	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "()V" );
	this->mJava_HasCachedBanner			= this->GetStaticMethod ( "hasCachedBanner", "()Z" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	this->mJava_HideBanner				= this->GetStaticMethod ( "hideBanner", "()V" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	this->mJava_InitBannerWithParams	= this->GetStaticMethod ( "initBannerWithParams", "(Ljava/lang/String;IIIZ)V" );
	this->mJava_ShowBanner				= this->GetStaticMethod ( "showBanner", "()V" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "()V" );
}

//----------------------------------------------------------------//
MOAIAdMobAndroid::~MOAIAdMobAndroid () {
}

//----------------------------------------------------------------//
void MOAIAdMobAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	luaL_Reg regTable [] = {
		{ "cacheBanner",				_cacheBanner },
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "hasCachedBanner",			_hasCachedBanner },
		{ "hideBanner",					_hideBanner },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIAdMobAndroid > },
		{ "init",						_init },
		{ "initBannerWithParams",		_initBannerWithParams },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIAdMobAndroid > },
		{ "showBanner",					_showBanner },
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

	MOAIAdMobAndroid::Get ().InvokeListener (( u32 )eventID );
}
