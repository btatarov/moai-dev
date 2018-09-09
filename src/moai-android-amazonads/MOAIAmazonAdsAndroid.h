// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef	MOAIAMAZONADSANDROID_H
#define	MOAIAMAZONADSANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIAmazonAdsAndroid
//================================================================//
class MOAIAmazonAdsAndroid :
	public MOAIGlobalClass < MOAIAmazonAdsAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_CacheBanner;
	jmethodID	mJava_CacheInterstitial;
	jmethodID	mJava_HasCachedBanner;
	jmethodID	mJava_HasCachedInterstitial;
	jmethodID	mJava_HideBanner;
	jmethodID	mJava_Init;
	jmethodID	mJava_InitBannerWithParams;
	jmethodID	mJava_ShowBanner;
	jmethodID	mJava_ShowInterstitial;

	//----------------------------------------------------------------//
	static int	_cacheBanner			( lua_State* L );
	static int	_cacheInterstitial		( lua_State* L );
	static int	_hasCachedBanner		( lua_State* L );
	static int	_hasCachedInterstitial	( lua_State* L );
	static int	_hideBanner		 		( lua_State* L );
	static int	_init	 				( lua_State* L );
	static int	_initBannerWithParams 	( lua_State* L );
	static int	_showBanner		 		( lua_State* L );
	static int	_showInterstitial 		( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIAmazonAdsAndroid );

	//----------------------------------------------------------------//
			MOAIAmazonAdsAndroid	();
			~MOAIAmazonAdsAndroid	();
	void	RegisterLuaClass		( MOAILuaState& state );
};


#endif
