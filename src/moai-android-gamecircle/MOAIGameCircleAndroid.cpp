// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-gamecircle/MOAIGameCircleAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIGameCircleAndroid::_connect ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGameCircleAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_Connect );

	return 0;
}

//----------------------------------------------------------------//
int MOAIGameCircleAndroid::_isConnected ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGameCircleAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_IsConnected ) );

	return 1;
}

//----------------------------------------------------------------//
int MOAIGameCircleAndroid::_showDefaultAchievements ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGameCircleAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowDefaultAchievements );

	return 0;
}

//----------------------------------------------------------------//
int MOAIGameCircleAndroid::_showDefaultLeaderboard ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGameCircleAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowDefaultLeaderboard );

	return 0;
}

//----------------------------------------------------------------//
int MOAIGameCircleAndroid::_reportScore ( lua_State *L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGameCircleAndroid, "" )

	jstring jleaderboardID = self->GetJString ( lua_tostring ( state, 1 ) );
	jlong score = lua_tonumber ( state, 2 );

	self->CallStaticVoidMethod ( self->mJava_ReportScore, jleaderboardID, score );

	return 0;
}

//----------------------------------------------------------------//
int MOAIGameCircleAndroid::_reportAchievementProgress ( lua_State *L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGameCircleAndroid, "" )

	jstring jAchievementID = self->GetJString ( lua_tostring ( state, 1 ) );
	jlong progress = lua_tonumber ( state, 2 );

	self->CallStaticVoidMethod ( self->mJava_ReportAchievementProgress, jAchievementID, progress );

	return 0;
}

//================================================================//
// MOAIGameCircleAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIGameCircleAndroid::MOAIGameCircleAndroid () {

	RTTI_SINGLE ( MOAILuaObject )

	this->SetClass ( "com/ziplinegames/moai/MoaiGameCircle" );

	this->mJava_Connect						= this->GetStaticMethod ( "connect", "()V");
	this->mJava_IsConnected					= this->GetStaticMethod ( "isConnected", "()Z" );
	this->mJava_ShowDefaultAchievements		= this->GetStaticMethod ( "showDefaultAchievements", "()V");
	this->mJava_ShowDefaultLeaderboard		= this->GetStaticMethod ( "showDefaultLeaderboard", "()V");
	this->mJava_ReportScore					= this->GetStaticMethod ( "reportScore", "(Ljava/lang/String;J)V");
	this->mJava_ReportAchievementProgress	= this->GetStaticMethod ( "reportAchievementProgress", "(Ljava/lang/String;J)V");
}

//----------------------------------------------------------------//
MOAIGameCircleAndroid::~MOAIGameCircleAndroid () {
}

//----------------------------------------------------------------//
void MOAIGameCircleAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "SERVICE_READY",		( u32 )SERVICE_READY );
	state.SetField ( -1, "SERVICE_NOT_READY",	( u32 )SERVICE_NOT_READY );

	luaL_Reg regTable [] = {
		{ "connect",					_connect },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIGameCircleAndroid > },
		{ "isConnected",				_isConnected },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIGameCircleAndroid > },
		{ "showDefaultAchievements",	_showDefaultAchievements },
		{ "showDefaultLeaderboard",		_showDefaultLeaderboard },
		{ "reportScore",				_reportScore },
		{ "reportAchievementProgress",	_reportAchievementProgress },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// GameCircle JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiGameCircle_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	MOAIGameCircleAndroid::Get ().InvokeListener (( u32 )eventID );
}
