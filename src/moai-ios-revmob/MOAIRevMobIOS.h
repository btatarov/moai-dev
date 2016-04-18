//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef	MOAIREVMOBIOS_H
#define	MOAIREVMOBIOS_H

#include <moai-core/headers.h>
#include <moai-ios/MOAILucidViewIOS.h>

#import <RevMobAds/RevMobAds.h>

@class MoaiRevMobContainerView;
@class MoaiRevMobDelegate;

//================================================================//
// MOAIRevMobIOS
//================================================================//
class MOAIRevMobIOS :
	public MOAIGlobalClass < MOAIRevMobIOS, MOAIGlobalEventSource > {
private:
		
	RevMobBannerView*			mBanner;
	MoaiRevMobContainerView*	mContainerView;
	RevMobFullscreen*			mInterstitial;
	MoaiRevMobDelegate*			mInterstitialDelegate;
	RevMobFullscreen*			mRewardedVideo;
	MoaiRevMobDelegate*			mRewardedVideoDelegate;

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
		FULLSCREEN_INTERSTITIAL,
		FULLSCREEN_REWARDED_VIDEO
	};
		
	enum {
		REVMOB_ADS_INITALIZED,
		REVMOB_ADS_FAILED,
		REWARDED_VIDEO_COMPLETED,
		TOTAL
	};
		
	BOOL mHasBanner = NO;
	BOOL mHasInterstitial = NO;
	BOOL mHasRewardedVideo = NO;

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

@property BOOL atBottom;
@property u32 margin;

@end

//================================================================//
// MoaiRevMobDelegate
//================================================================//
@interface MoaiRevMobDelegate : NSObject < RevMobAdsDelegate > {
	
	@private
}

@property u32 adType;

@end

#endif  //MOAIREVMOBIOS_H
