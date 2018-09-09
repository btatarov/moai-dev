// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef	MOAIGOOGLEPLAYSERVICESANDROID_H
#define	MOAIGOOGLEPLAYSERVICESANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIGooglePlayServicesAndroid
//================================================================//
/**	@lua	MOAIGooglePlayServicesAndroid
	@text	Wrapper for Google Play services.
*/
class MOAIGooglePlayServicesAndroid :
	public MOAIGlobalClass < MOAIGooglePlayServicesAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_Connect;
	jmethodID	mJava_IsConnected;
	jmethodID	mJava_ShowAchievements;
	jmethodID	mJava_ShowLeaderboard;
	jmethodID	mJava_SubmitScore;
	jmethodID	mJava_UnlockAchievement;

	//----------------------------------------------------------------//
	static int			_connect				( lua_State* L );
	static int			_isConnected			( lua_State* L );
	static int			_showAchievements		( lua_State* L );
	static int			_showLeaderboard		( lua_State* L );
	static int			_submitScore			( lua_State* L );
	static int			_unlockAchievement		( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIGooglePlayServicesAndroid );

	enum {
		CONNECTION_COMPLETE,
		CONNECTION_FAILED,
	};

			MOAIGooglePlayServicesAndroid		();
			~MOAIGooglePlayServicesAndroid		();
	void	RegisterLuaClass					( MOAILuaState& state );
};


#endif  //MOAIGOOGLEPLAYSERVICESANDROID_H
