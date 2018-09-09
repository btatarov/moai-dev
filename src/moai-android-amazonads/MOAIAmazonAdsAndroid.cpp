// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-amazonads/MOAIAmazonAdsAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_cacheBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheBanner );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_cacheInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_hasCachedBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedBanner ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_hasCachedInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_hideBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_HideBanner );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_init ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	jstring jappID = self->GetJString ( lua_tostring ( state, 1 ) );
	self->CallStaticVoidMethod ( self->mJava_Init, jappID );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_initBannerWithParams ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	u32 width  = lua_tonumber ( state, 1 );
	u32 height = lua_tonumber ( state, 2 );
	u32 margin = lua_tonumber ( state, 3 );
	bool bottom = lua_toboolean ( state, 4 );

	self->CallStaticVoidMethod ( self->mJava_InitBannerWithParams, width, height, margin, bottom );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_showBanner ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowBanner );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAmazonAdsAndroid::_showInterstitial ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIAmazonAdsAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial );

	return 0;
}

//================================================================//
// MOAIAmazonAdsAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIAmazonAdsAndroid::MOAIAmazonAdsAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiAmazonAds" );

	this->mJava_CacheBanner				= this->GetStaticMethod ( "cacheBanner", "()V" );
	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "()V" );
	this->mJava_HasCachedBanner			= this->GetStaticMethod ( "hasCachedBanner", "()Z" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "()Z" );
	this->mJava_HideBanner				= this->GetStaticMethod ( "hideBanner", "()V" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	this->mJava_InitBannerWithParams	= this->GetStaticMethod ( "initBannerWithParams", "(IIIZ)V" );
	this->mJava_ShowBanner				= this->GetStaticMethod ( "showBanner", "()V" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "()V" );
}

//----------------------------------------------------------------//
MOAIAmazonAdsAndroid::~MOAIAmazonAdsAndroid () {
}

//----------------------------------------------------------------//
void MOAIAmazonAdsAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	luaL_Reg regTable [] = {
		{ "cacheBanner",				_cacheBanner },
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "hasCachedBanner",			_hasCachedBanner },
		{ "hideBanner",					_hideBanner },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIAmazonAdsAndroid > },
		{ "init",						_init },
		{ "initBannerWithParams",		_initBannerWithParams },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIAmazonAdsAndroid > },
		{ "showBanner",					_showBanner },
		{ "showInterstitial",			_showInterstitial },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// AmazonAds JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiAmazonAds_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	MOAIAmazonAdsAndroid::Get ().InvokeListener (( u32 )eventID );
}
