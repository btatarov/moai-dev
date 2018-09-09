// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-adcolony/MOAIAdColonyAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIAdColonyAndroid::_cacheRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdColonyAndroid, "" )

	jstring jZoneId = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_CacheRewardedVideo, jZoneId );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdColonyAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdColonyAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedRewardedVideo ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdColonyAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdColonyAndroid, "" )

	jstring jAppId			= self->GetJString ( lua_tostring ( state, 1 ) );
	bool amazon_store 		= lua_toboolean ( state, 2 );
	jobjectArray jzones		= self->StringArrayFromLua ( state, 3 );

	self->CallStaticVoidMethod ( self->mJava_Init, jAppId, amazon_store, jzones );

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdColonyAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIAdColonyAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowRewardedVideo );

	return 0;
}

//================================================================//
// MOAIAdColonyAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIAdColonyAndroid::MOAIAdColonyAndroid () {

	RTTI_SINGLE ( MOAILuaObject )

	this->SetClass ( "com/ziplinegames/moai/MoaiAdColony" );

	this->mJava_CacheRewardedVideo		= this->GetStaticMethod ( "cacheRewardedVideo", "(Ljava/lang/String;)V" );
	this->mJava_HasCachedRewardedVideo	= this->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;Z[Ljava/lang/String;)V" );
	this->mJava_ShowRewardedVideo		= this->GetStaticMethod ( "showRewardedVideo", "()V" );
}

//----------------------------------------------------------------//
MOAIAdColonyAndroid::~MOAIAdColonyAndroid () {
}

//----------------------------------------------------------------//
void MOAIAdColonyAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED", 		( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIAdColonyAndroid > },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIAdColonyAndroid > },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// AdColony JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiAdColony_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MOAIAdColonyAndroid_AKUInvokeListener\n" );
	MOAIAdColonyAndroid::Get ().InvokeListener (( u32 )eventID );
}
