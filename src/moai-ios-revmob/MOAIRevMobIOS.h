//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef	MOAIREVMOBIOS_H
#define	MOAIREVMOBIOS_H

#include <moai-core/headers.h>
#include <moai-ios/MOAILucidViewIOS.h>

#import <RevMob/RevMob.h>

@class MoaiRevMobContainerView;
@class MoaiRevMobDelegate;

//================================================================//
// MOAIRevMobIOS
//================================================================//
class MOAIRevMobIOS :
	public MOAIGlobalClass < MOAIRevMobIOS, MOAIGlobalEventSource > {
private:

	MoaiRevMobDelegate*			mRevMobDelegate;

	//----------------------------------------------------------------//
	static int		_cacheBanner					( lua_State* L );
	static int		_cacheInterstitial				( lua_State* L );
	static int		_cacheRewardedVideo				( lua_State* L );
	static int		_hasCachedBanner				( lua_State* L );
	static int		_hasCachedInterstitial			( lua_State* L );
	static int		_hasCachedRewardedVideo			( lua_State* L );
	static int		_hideBanner						( lua_State* L );
	static int		_init							( lua_State* L );
	static int		_initBannerWithParams			( lua_State* L );
	static int		_showBanner						( lua_State* L );
	static int		_showInterstitial				( lua_State* L );
	static int		_showRewardedVideo				( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIRevMobIOS );

	enum {
		REWARDED_VIDEO_COMPLETED,
		TOTAL
	};

	RMBannerView*				mBannerView;
	MoaiRevMobContainerView*	mContainerView;
	BOOL 						mHasBanner = NO;

	//----------------------------------------------------------------//
					MOAIRevMobIOS					();
					~MOAIRevMobIOS					();
	void			RegisterLuaClass				( MOAILuaState& state );
};

//================================================================//
// MoaiRevMobContainerView
//================================================================//
@interface MoaiRevMobContainerView : MOAILucidViewIOS {

	@private
}

@end

//================================================================//
// MoaiRevMobDelegate
//================================================================//
@interface MoaiRevMobDelegate : NSObject < RevmobDelegate > {

	@private
}

@end

#endif  //MOAIREVMOBIOS_H
