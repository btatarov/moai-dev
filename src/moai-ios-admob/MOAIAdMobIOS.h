//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef	MOAIADMOBIOS_H
#define	MOAIADMOBIOS_H

#include <moai-core/headers.h>
#include <moai-ios/MOAILucidViewIOS.h>
#import <GoogleMobileAds/GoogleMobileAds.h>
#import <UIKit/UIKit.h>

@class MoaiAdMobBannerDelegate;
@class MoaiAdMobContainerView;

//================================================================//
// MOAIAdMobIOS
//================================================================//
class MOAIAdMobIOS :
	public MOAIGlobalClass < MOAIAdMobIOS, MOAIGlobalEventSource > {
private:

	//----------------------------------------------------------------//
	static int		_cacheBanner				( lua_State* L );
	static int		_cacheInterstitial			( lua_State* L );
	static int		_hasCachedBanner			( lua_State* L );
	static int		_hasCachedInterstitial		( lua_State* L );
	static int		_hideBanner					( lua_State* L );
	static int		_init						( lua_State* L );
	static int		_initBannerWithParams		( lua_State* L );
	static int		_showBanner					( lua_State* L );
	static int		_showInterstitial			( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIAdMobIOS );

	GADBannerView*				mBannerView;
	MoaiAdMobBannerDelegate*	mBannerDelegate;
	MoaiAdMobContainerView*		mContainerView;
	GADInterstitial*			mInterstitial;
	BOOL						mHasCachedBanner = NO;

	//----------------------------------------------------------------//
					MOAIAdMobIOS				();
					~MOAIAdMobIOS				();
	void			RegisterLuaClass			( MOAILuaState& state );
};

//================================================================//
// MoaiAdMobContainerView
//================================================================//
@interface MoaiAdMobContainerView : MOAILucidViewIOS

	@property BOOL		atBottom;
	@property BOOL		alreadyPositioned;
	@property CGFloat	margin;

@end

//================================================================//
// MoaiAdMobBannerDelegate
//================================================================//
@interface MoaiAdMobBannerDelegate : NSObject < GADBannerViewDelegate > {
@private
}
@end

#endif  //MOAIADMOBIOS_H
