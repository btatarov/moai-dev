//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios-revmob/MOAIRevMobIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIRevMobIOS::_cacheBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	[ Revmob cacheBanner ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_cacheInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	[ Revmob cacheInterstitial ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_cacheRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	[ Revmob cacheRewardedVideo ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_hasCachedBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	lua_pushboolean ( state, MOAIRevMobIOS::Get ().mHasBanner );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_hasCachedInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	lua_pushboolean ( state, [ Revmob hasAdCachedOnAdUnit:RMInterstitial withPlacement:nil ] );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_hasCachedRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	lua_pushboolean ( state, [ Revmob hasAdCachedOnAdUnit:RMRewardedVideo withPlacement:nil ] );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_hideBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	// MOAIRevMobIOS::Get ().mBannerView.hidden = YES;
	[ MOAIRevMobIOS::Get ().mBannerView removeFromSuperview ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* appID = lua_tostring ( state, 1 );

	[ Revmob initWithAppId:[ NSString stringWithUTF8String:appID ] ];
	[ Revmob setDelegate:MOAIRevMobIOS::Get ().mRevMobDelegate ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_initBannerWithParams ( lua_State* L ) {

	MOAILuaState state ( L );

	u32		margin			= lua_tonumber ( state, 1 );
	u32		bannerWidth		= lua_tonumber ( state, 2 );
	u32		bannerHeight 	= lua_tonumber ( state, 3 );
	BOOL	atBottom		= lua_toboolean ( state, 4 );

	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];

	// wrapper bounds
	CGRect screenRect	= [ [ UIScreen mainScreen ] bounds ];
	CGFloat scale		= [ [ UIScreen mainScreen ] scale ];

	if ( bannerWidth < 1 ) bannerWidth = screenRect.size.width * scale;
	if ( bannerHeight < 1 ) bannerHeight = bannerWidth / 3;

	CGFloat left_margin = ( screenRect.size.width - bannerWidth / scale );

	CGFloat top_margin;
	if ( atBottom ) {
		top_margin = screenRect.size.height - bannerHeight / scale - margin / scale;
	} else {
		top_margin = margin / scale;
	}

	CGRect containerRect = CGRectMake ( left_margin, top_margin, screenRect.size.width - left_margin * 2, bannerHeight / scale );

	MoaiRevMobContainerView* container = [ MOAIRevMobIOS::Get ().mContainerView initWithFrame:containerRect ];

	[ rootVC.view addSubview:container ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_showBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( MOAIRevMobIOS::Get ().mHasBanner ) {

		MOAIRevMobIOS::Get ().mBannerView.hidden = NO;
		MOAIRevMobIOS::Get ().mHasBanner = NO;
	}

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_showInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( [ Revmob hasAdCachedOnAdUnit:RMInterstitial withPlacement:nil ] ) {

		[ Revmob showInterstitial ];
	}

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_showRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( [ Revmob hasAdCachedOnAdUnit:RMRewardedVideo withPlacement:nil ] ) {

		[ Revmob showRewardedVideo ];
	}

	return 0;
}

//================================================================//
// MOAIRevMobIOS
//================================================================//

//----------------------------------------------------------------//
MOAIRevMobIOS::MOAIRevMobIOS () {

	RTTI_SINGLE ( MOAILuaObject )

	mContainerView = [ MoaiRevMobContainerView alloc ];
	mRevMobDelegate = [[ MoaiRevMobDelegate alloc ] init ];
}

//----------------------------------------------------------------//
MOAIRevMobIOS::~MOAIRevMobIOS () {

	[ mContainerView release ];
	[ mRevMobDelegate release ];
}

//----------------------------------------------------------------//
void MOAIRevMobIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED", 	( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheBanner",			_cacheBanner },
		{ "cacheInterstitial",		_cacheInterstitial },
		{ "cacheRewardedVideo",		_cacheRewardedVideo },
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIRevMobIOS > },
		{ "hasCachedBanner",		_hasCachedBanner },
		{ "hasCachedInterstitial",	_hasCachedInterstitial },
		{ "hasCachedRewardedVideo",	_hasCachedRewardedVideo },
		{ "init",					_init },
		{ "initBannerWithParams",	_initBannerWithParams },
		{ "hideBanner",				_hideBanner },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIRevMobIOS > },
		{ "showBanner",				_showBanner },
		{ "showInterstitial",		_showInterstitial },
		{ "showRewardedVideo",		_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// MoaiRevMobContainerView
//================================================================//
@implementation MoaiRevMobContainerView

@end

//================================================================//
// MoaiRevMobDelegate
//================================================================//
@implementation MoaiRevMobDelegate

	//================================================================//
	#pragma mark -
	#pragma mark Protocol RevMobDelegate
	//================================================================//

	//----------------------------------------------------------------//
	- (void)revmobDidCacheAd:(RMAdUnits)adUnit withPlacement:(NSString *)placement {
		if ( adUnit == RMBanner ) {

			MOAIRevMobIOS::Get ().mHasBanner = YES;

			MoaiRevMobContainerView* container = MOAIRevMobIOS::Get ().mContainerView;

			MOAIRevMobIOS::Get ().mBannerView = [ Revmob getBanner ];
			[ MOAIRevMobIOS::Get ().mBannerView setFrame:CGRectMake ( 0, 0, container.bounds.size.width, container.bounds.size.height ) ];
			MOAIRevMobIOS::Get ().mBannerView.hidden = YES;

			[ container addSubview:MOAIRevMobIOS::Get ().mBannerView ];
		}
	}

	//----------------------------------------------------------------//
	- ( void )revmobRewardedVideoActionDidCompleteOnPlacement:(NSString *)placement {

		MOAIRevMobIOS::Get ().InvokeListener ( MOAIRevMobIOS::REWARDED_VIDEO_COMPLETED );
	}

@end
