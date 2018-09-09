// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-chartboost/MOAIChartBoostAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIChartBoostAndroid::_cacheInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIChartBoostAndroid, "" )

	jstring jlocation = self->GetJString ( lua_tostring ( state, 1 ) );
	self->CallStaticVoidMethod ( self->mJava_CacheInterstitial, jlocation );

	return 0;
}

//----------------------------------------------------------------//
int MOAIChartBoostAndroid::_hasCachedInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIChartBoostAndroid, "" )

	jstring jlocation = self->GetJString ( lua_tostring ( state, 1 ) );
	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedInterstitial, jlocation ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIChartBoostAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIChartBoostAndroid, "" )

	jstring jappID			= self->GetJString ( lua_tostring ( state, 1 ) );
	jstring jappSignature	= self->GetJString ( lua_tostring ( state, 2 ) );
	self->CallStaticVoidMethod ( self->mJava_Init, jappID, jappSignature );

	return 0;
}

//----------------------------------------------------------------//
int MOAIChartBoostAndroid::_showInterstitial ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIChartBoostAndroid, "" )

	jstring jlocation = self->GetJString ( lua_tostring ( state, 1 ) );
	self->CallStaticVoidMethod ( self->mJava_ShowInterstitial, jlocation );
	return 0;
}

//================================================================//
// MOAIChartBoostAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIChartBoostAndroid::MOAIChartBoostAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiChartBoost" );

	this->mJava_CacheInterstitial		= this->GetStaticMethod ( "cacheInterstitial", "(Ljava/lang/String;)V" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;Ljava/lang/String;)V" );
	this->mJava_HasCachedInterstitial	= this->GetStaticMethod ( "hasCachedInterstitial", "(Ljava/lang/String;)Z" );
	this->mJava_ShowInterstitial		= this->GetStaticMethod ( "showInterstitial", "(Ljava/lang/String;)V" );
}

//----------------------------------------------------------------//
MOAIChartBoostAndroid::~MOAIChartBoostAndroid () {
}

//----------------------------------------------------------------//
void MOAIChartBoostAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "INTERSTITIAL_LOAD_FAILED",	( u32 )INTERSTITIAL_LOAD_FAILED );
	state.SetField ( -1, "INTERSTITIAL_DISMISSED", 		( u32 )INTERSTITIAL_DISMISSED );

	luaL_Reg regTable [] = {
		{ "cacheInterstitial",			_cacheInterstitial },
		{ "hasCachedInterstitial",		_hasCachedInterstitial },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIChartBoostAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIChartBoostAndroid > },
		{ "showInterstitial",			_showInterstitial },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// ChartBoost JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiChartBoost_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiChartBoost_AKUInvokeListener\n" );
	MOAIChartBoostAndroid::Get ().InvokeListener (( u32 )eventID );
}
