// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef MOAIVUNGLEANDROID_H
#define MOAIVUNGLEANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIVungleAndroid
//================================================================//
class MOAIVungleAndroid :
	public MOAIGlobalClass < MOAIVungleAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_cacheRewardedVideo;
	jmethodID	mJava_HasCachedRewardedVideo;
	jmethodID	mJava_Init;
	jmethodID	mJava_ShowRewardedVideo;

	//----------------------------------------------------------------//
	static int	_cacheRewardedVideo				( lua_State* L );
	static int	_hasCachedRewardedVideo		( lua_State* L );
	static int	_init											( lua_State* L );
	static int	_showRewardedVideo				( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIVungleAndroid );

	enum {
		REWARDED_VIDEO_STARTED,
		REWARDED_VIDEO_FINISH,
		REWARDED_VIDEO_COMPLETED,
	};

	//----------------------------------------------------------------//
			MOAIVungleAndroid			();
			~MOAIVungleAndroid		();
	void	RegisterLuaClass		( MOAILuaState& state );
};


#endif  //MOAIADCOLONY_H
