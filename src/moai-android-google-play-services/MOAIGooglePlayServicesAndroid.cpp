// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-google-play-services/MOAIGooglePlayServicesAndroid.h>

extern JavaVM* jvm;

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
/**	@lua	connect
	@text	Connects to the Google Play Game Services

	@out	nil
*/
int MOAIGooglePlayServicesAndroid::_connect ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGooglePlayServicesAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_Connect );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	isConnected
	@text	Checks if services are connected.

	@out	boolean
*/
int MOAIGooglePlayServicesAndroid::_isConnected ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGooglePlayServicesAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_IsConnected ) );

	return 1;
}

//----------------------------------------------------------------//
/**	@lua	showAchievements
	@text	Shows the achievements

	@out	nil
*/
int MOAIGooglePlayServicesAndroid::_showAchievements ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGooglePlayServicesAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_ShowAchievements );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	showLeaderboard
	@text	Shows the desired leaderboard

	@in		string leaderboardID
	@out	nil
*/
int MOAIGooglePlayServicesAndroid::_showLeaderboard ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGooglePlayServicesAndroid, "" )

	jstring jleaderboardID = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_ShowLeaderboard, jleaderboardID );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	submitScore
	@text	Submits a score for the passed in leaderboard

	@in		string leaderboardID
	@in		number score
	@out	nil
*/
int MOAIGooglePlayServicesAndroid::_submitScore ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGooglePlayServicesAndroid, "" )

	jstring jleaderboardID = self->GetJString ( lua_tostring ( state, 1 ) );
	jlong score = lua_tonumber ( state, 2 );

	self->CallStaticVoidMethod ( self->mJava_SubmitScore, jleaderboardID, score );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	unlockAchievement
	@text	Grants an achievement to the player

	@in		string achievementID
	@out	nil
*/
int MOAIGooglePlayServicesAndroid::_unlockAchievement ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIGooglePlayServicesAndroid, "" )

	jstring jachievementID = self->GetJString ( lua_tostring ( state, 1 ) );

	self->CallStaticVoidMethod ( self->mJava_UnlockAchievement, jachievementID );

	return 0;
}


//================================================================//
// MOAIGooglePlayServicesAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIGooglePlayServicesAndroid::MOAIGooglePlayServicesAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiGooglePlayServices" );

	this->mJava_Connect				= this->GetStaticMethod ( "connect", "()V" );
	this->mJava_IsConnected			= this->GetStaticMethod ( "isConnected", "()Z" );
	this->mJava_ShowAchievements	= this->GetStaticMethod ( "showAchievements", "()V" );
	this->mJava_ShowLeaderboard		= this->GetStaticMethod ( "showLeaderboard", "(Ljava/lang/String;)V" );
	this->mJava_SubmitScore			= this->GetStaticMethod ( "submitScore", "(Ljava/lang/String;J)V" );
	this->mJava_UnlockAchievement	= this->GetStaticMethod ( "unlockAchievement", "(Ljava/lang/String;)V" );
}

//----------------------------------------------------------------//
MOAIGooglePlayServicesAndroid::~MOAIGooglePlayServicesAndroid () {

}

//----------------------------------------------------------------//
void MOAIGooglePlayServicesAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "CONNECTION_COMPLETE",		( u32 )CONNECTION_COMPLETE );
	state.SetField ( -1, "CONNECTION_FAILED",		( u32 )CONNECTION_FAILED );

	luaL_Reg regTable [] = {
		{ "connect", 				_connect },
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIGooglePlayServicesAndroid > },
		{ "isConnected",			_isConnected },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIGooglePlayServicesAndroid > },
		{ "showAchievements",		_showAchievements },
		{ "showLeaderboard",		_showLeaderboard },
		{ "submitScore",			_submitScore },
		{ "unlockAchievement",		_unlockAchievement },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

// AKU Callbacks

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiGooglePlayServices_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	MOAIGooglePlayServicesAndroid::Get ().InvokeListener (( u32 )eventID );
}
