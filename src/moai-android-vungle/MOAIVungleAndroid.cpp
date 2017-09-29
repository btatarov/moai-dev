// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-vungle/MOAIVungleAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIVungleAndroid::_showRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIVungleAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowRewardedVideo );

	return 0;
}

//----------------------------------------------------------------//
int	MOAIVungleAndroid::_init ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIVungleAndroid, "" )

	jstring jappID = self->GetJString ( lua_tostring ( state, 1 ));

	self->CallStaticVoidMethod ( self->mJava_Init, jappID );

	return 0;
}

//----------------------------------------------------------------//
int	MOAIVungleAndroid::_hasCachedRewardedVideo ( lua_State* L ) {
	MOAI_JAVA_LUA_SETUP ( MOAIVungleAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_HasCachedRewardedVideo ) );

	return 1;
}

//================================================================//
// MOAIVungleAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIVungleAndroid::MOAIVungleAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiVungle" );

	this->mJava_Init					= this->GetStaticMethod ( "init", "(Ljava/lang/String;)V" );
	this->mJava_HasCachedRewardedVideo	= this->GetStaticMethod ( "hasCachedRewardedVideo", "()Z" );
	this->mJava_ShowRewardedVideo		= this->GetStaticMethod ( "showRewardedVideo", "()V" );
}

//----------------------------------------------------------------//
MOAIVungleAndroid::~MOAIVungleAndroid () {
}

//----------------------------------------------------------------//
void MOAIVungleAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_STARTED",		( u32 )REWARDED_VIDEO_STARTED );
	state.SetField ( -1, "REWARDED_VIDEO_FINISH", 		( u32 )REWARDED_VIDEO_FINISH );
	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED", 	( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "showRewardedVideo",			_showRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIVungleAndroid > },
		{ "init",						_init },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIVungleAndroid > },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// Vungle JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiVungle_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiVungle_AKUInvokeListener\n" );
	MOAIVungleAndroid::Get ().InvokeListener (( u32 )eventID );
}

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiVungle_AKUOnView ( JNIEnv* env, jclass obj, jdouble watched, jdouble length ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiVungle_AKUOnView\n" );
	MOAIScopedLuaState state = MOAILuaRuntime::Get ().State ();
	if ( MOAIVungleAndroid::Get ().PushListener ( MOAIVungleAndroid::REWARDED_VIDEO_COMPLETED, state )) {
		state.Push ( watched == length );
		state.DebugCall ( 1, 0 );
	}
}
