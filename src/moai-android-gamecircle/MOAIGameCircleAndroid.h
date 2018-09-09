// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef MOAIGAMECIRCLEANDROID_H
#define MOAIGAMECIRCLEANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIGameCircleAndroid
//================================================================//
class MOAIGameCircleAndroid :
	public MOAIGlobalClass < MOAIGameCircleAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_Connect;
	jmethodID	mJava_IsConnected;
	jmethodID	mJava_ShowDefaultAchievements;
	jmethodID	mJava_ShowLeaderboard;
	jmethodID	mJava_ReportScore;
	jmethodID	mJava_ReportAchievementProgress;

	//----------------------------------------------------------------//
	static int  _connect					( lua_State* L );
	static int  _isConnected				( lua_State* L );
	static int	_showDefaultAchievements	( lua_State* L );
	static int	_showLeaderboard			( lua_State* L );
	static int  _reportScore				( lua_State* L );
	static int  _reportAchievementProgress	( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIGameCircleAndroid );

	enum {
		SERVICE_READY,
		SERVICE_NOT_READY,
	};

	//----------------------------------------------------------------//
			MOAIGameCircleAndroid	();
			~MOAIGameCircleAndroid	();
	void	RegisterLuaClass		( MOAILuaState& state );
};

#endif  //MOAIGAMECIRCLEANDROID_H
