// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef	MOAIHEYZAPANDROID_H
#define	MOAIHEYZAPANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIHeyZapAndroid
//================================================================//
class MOAIHeyZapAndroid :
	public MOAIGlobalClass < MOAIHeyZapAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_CacheInterstitial;
	jmethodID	mJava_CacheRewardedVideo;
	jmethodID	mJava_HasCachedInterstitial;
	jmethodID	mJava_HasCachedRewardedVideo;
	jmethodID	mJava_Init;
	jmethodID	mJava_ShowInterstitial;
	jmethodID	mJava_ShowRewardedVideo;

	//----------------------------------------------------------------//
	static int	_cacheInterstitial		( lua_State* L );
	static int	_cacheRewardedVideo		( lua_State* L );
	static int	_hasCachedInterstitial	( lua_State* L );
	static int	_hasCachedRewardedVideo	( lua_State* L );
	static int	_init	 				( lua_State* L );
	static int	_showInterstitial 		( lua_State* L );
	static int	_showRewardedVideo 		( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIHeyZapAndroid );

	enum {
		REWARDEDVIDEOAD_COMPLETED,
	};

	//----------------------------------------------------------------//
			MOAIHeyZapAndroid	();
			~MOAIHeyZapAndroid	();
	void	RegisterLuaClass	( MOAILuaState& state );
};


#endif  //MOAIHEYZAPANDROID_H
