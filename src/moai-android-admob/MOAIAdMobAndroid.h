// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef	MOAIADMOBANDROID_H
#define	MOAIADMOBANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIAdMobAndroid
//================================================================//
class MOAIAdMobAndroid :
	public MOAIGlobalClass < MOAIAdMobAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_Init;
	jmethodID	mJava_CacheInterstitial;
	jmethodID	mJava_HasCachedInterstitial;
	jmethodID	mJava_ShowInterstitial;

	//----------------------------------------------------------------//
	static int	_cacheInterstitial		( lua_State* L );
	static int	_hasCachedInterstitial	( lua_State* L );
	static int	_init	 				( lua_State* L );
	static int	_showInterstitial 		( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIAdMobAndroid );

	enum {
		INTERSTITIAL_LOAD_FAILED,
		INTERSTITIAL_DISMISSED,
	};

	//----------------------------------------------------------------//
			MOAIAdMobAndroid		();
			~MOAIAdMobAndroid		();
	void	RegisterLuaClass		( MOAILuaState& state );
};


#endif  //MOAIADMOB_H
