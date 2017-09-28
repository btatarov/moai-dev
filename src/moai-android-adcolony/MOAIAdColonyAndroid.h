// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef MOAIADCOLONYANDROID_H
#define MOAIADCOLONYANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIAdColonyAndroid
//================================================================//
class MOAIAdColonyAndroid :
	public MOAIGlobalClass < MOAIAdColonyAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_CacheRewardedVideo;
	jmethodID	mJava_HasCachedRewardedVideo;
	jmethodID	mJava_Init;
	jmethodID	mJava_ShowRewardedVideo;

	//----------------------------------------------------------------//
	static int	_cacheRewardedVideo		( lua_State* L );
	static int	_hasCachedRewardedVideo	( lua_State* L );
	static int	_init	 				( lua_State* L );
	static int	_showRewardedVideo 		( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIAdColonyAndroid );

	enum {
		REWARDED_VIDEO_COMPLETED,
	};

	//----------------------------------------------------------------//
			MOAIAdColonyAndroid		();
			~MOAIAdColonyAndroid	();
	void	RegisterLuaClass		( MOAILuaState& state );
};


#endif  //MOAIADCOLONY_H
