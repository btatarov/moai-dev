//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef	MOAISTARTAPPIOS_H
#define	MOAISTARTAPPIOS_H

#include <moai-core/headers.h>
#include <moai-ios/MOAILucidViewIOS.h>

#import <StartApp/StartApp.h>
#import <UIKit/UIKit.h>

@class MoaiStartAppContainerView;

//================================================================//
// MOAIStartAppIOS
//================================================================//
class MOAIStartAppIOS :
	public MOAIGlobalClass < MOAIStartAppIOS, MOAIGlobalEventSource > {
private:

	STABannerView*				mBannerView;

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

	DECL_LUA_SINGLETON ( MOAIStartAppIOS );

	MoaiStartAppContainerView*		mContainerView;
	BOOL							mHasCachedBanner = NO;
	STAStartAppAd*					mInterstitial;
	STAStartAppAd*					mRewardedVideo;

	//----------------------------------------------------------------//
					MOAIStartAppIOS				();
				   ~MOAIStartAppIOS				();
	void			RegisterLuaClass			( MOAILuaState& state );
};

//================================================================//
// MoaiStartAppContainerView
//================================================================//
@interface MoaiStartAppContainerView : MOAILucidViewIOS < STABannerDelegateProtocol > {
}
@end

#endif  //MOAISTARTAPPIOS_H
