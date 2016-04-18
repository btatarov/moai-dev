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
	
	MOAIRevMobIOS::Get ().mBanner = [[RevMobAds session] bannerView ];

	[ MOAIRevMobIOS::Get ().mBanner
		loadWithSuccessHandler:^( RevMobBannerView* bannerView )  {
			
			// Sizes taken from RevMobAds.h
			CGFloat ratio;
			if ( UI_USER_INTERFACE_IDIOM () == UIUserInterfaceIdiomPad ) {
				
				ratio = 114.0 / 768.0;
			} else {
				
				ratio = 50.0 / 320.0;
			}
			
			MoaiRevMobContainerView* container = MOAIRevMobIOS::Get ().mContainerView;
			CGRect viewFrame = container.frame;
			CGRect bannerFrame = CGRectMake ( 0, 0, viewFrame.size.width, viewFrame.size.width * ratio );
			
			CGRect screenRect = [[ UIScreen mainScreen ] bounds ];
			CGFloat scale = [[ UIScreen mainScreen ] scale ];
			CGFloat screenHeight = screenRect.size.height;
			
			if ( container.atBottom ) {
				
				viewFrame.origin.y = screenHeight - bannerFrame.size.height - container.margin / scale;
			} else {
				
				viewFrame.origin.y = container.margin / scale;
			}
			
			bannerView.hidden = YES;
			[ bannerView setFrame:bannerFrame ];
			
			[ container setFrame:viewFrame ];
			[ container addSubview:bannerView ];
			
			MOAIRevMobIOS::Get ().mHasBanner = YES;
		}
	 
		 andLoadFailHandler:^( RevMobBannerView* bannerView, NSError* error ) {
			 
			 UNUSED ( bannerView );
			 UNUSED ( error );
		 }
		onClickHandler:^( RevMobBannerView* bannerView ) {
			
			UNUSED ( bannerView );
		}
	];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_cacheInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );
	
	MOAIRevMobIOS::Get ().mInterstitial = [ [ RevMobAds session ] fullscreen ];
	MOAIRevMobIOS::Get ().mInterstitial.delegate = MOAIRevMobIOS::Get ().mInterstitialDelegate;
	[ MOAIRevMobIOS::Get ().mInterstitial loadAd ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_cacheRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );
	
	MOAIRevMobIOS::Get ().mRewardedVideo = [ [ RevMobAds session ] fullscreen ];
	MOAIRevMobIOS::Get ().mRewardedVideo.delegate = MOAIRevMobIOS::Get ().mRewardedVideoDelegate;
	[ MOAIRevMobIOS::Get ().mRewardedVideo loadRewardedVideo ];

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

	lua_pushboolean ( state, MOAIRevMobIOS::Get ().mHasInterstitial );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_hasCachedRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	lua_pushboolean ( state, MOAIRevMobIOS::Get ().mHasRewardedVideo );

	return 1;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_hideBanner ( lua_State* L ) {

	MOAILuaState state ( L );
	
	MOAIRevMobIOS::Get ().mBanner.hidden = YES;
	[ MOAIRevMobIOS::Get ().mBanner removeFromSuperview ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* appID = lua_tostring ( state, 1 );
	
	[ RevMobAds
		startSessionWithAppID:[ NSString stringWithUTF8String:appID ]
		withSuccessHandler:^{
		   
			MOAIRevMobIOS::Get ().InvokeListener ( MOAIRevMobIOS::REVMOB_ADS_INITALIZED );
		}
		andFailHandler:^( NSError* error ) {
			
			UNUSED ( error );
			
			MOAIRevMobIOS::Get ().InvokeListener ( MOAIRevMobIOS::REVMOB_ADS_FAILED );
		}
	 ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_initBannerWithParams ( lua_State* L ) {
	
	MOAILuaState state ( L );
	
	u32		margin		= lua_tonumber ( state, 1 );
	u32		bannerWidth	= lua_tonumber ( state, 2 );
	BOOL	atBottom	= lua_toboolean ( state, 3 );
	
	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];
	
	// wrapper bounds
	CGRect screenRect	= [ [ UIScreen mainScreen ] bounds ];
	CGFloat scale		= [ [ UIScreen mainScreen ] scale ];
	
	if ( bannerWidth < 1 ) bannerWidth = screenRect.size.width * scale;
	
	CGFloat left_margin = ( screenRect.size.width - bannerWidth / scale );
	
	CGRect containerRect = CGRectMake ( left_margin, margin / scale, screenRect.size.width - left_margin * 2, screenRect.size.height - margin / scale * 2 );
	
	MoaiRevMobContainerView* container = [ MOAIRevMobIOS::Get ().mContainerView initWithFrame:containerRect ];
	
	container.atBottom = atBottom;
	container.margin = margin;
	[ rootVC.view addSubview:container ];
	
	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_showBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( MOAIRevMobIOS::Get ().mHasBanner ) {

		MOAIRevMobIOS::Get ().mHasBanner = NO;
		MOAIRevMobIOS::Get ().mBanner.hidden = NO;
	}

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_showInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( MOAIRevMobIOS::Get ().mHasInterstitial ) {
		
		MOAIRevMobIOS::Get ().mHasInterstitial = NO;
		[ MOAIRevMobIOS::Get ().mInterstitial showAd ];
	}

	return 0;
}

//----------------------------------------------------------------//
int MOAIRevMobIOS::_showRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( MOAIRevMobIOS::Get ().mHasRewardedVideo ) {
		
		MOAIRevMobIOS::Get ().mHasRewardedVideo = NO;
		[ MOAIRevMobIOS::Get ().mRewardedVideo showRewardedVideo ];
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
	mInterstitialDelegate = [[ MoaiRevMobDelegate alloc ] init ];
	mRewardedVideoDelegate = [[ MoaiRevMobDelegate alloc ] init ];
	
	mInterstitialDelegate.adType = FULLSCREEN_INTERSTITIAL;
	mRewardedVideoDelegate.adType = FULLSCREEN_REWARDED_VIDEO;
}

//----------------------------------------------------------------//
MOAIRevMobIOS::~MOAIRevMobIOS () {

	[ mContainerView release ];
	[ mInterstitialDelegate release ];
	[ mRewardedVideoDelegate release ];
}

//----------------------------------------------------------------//
void MOAIRevMobIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REVMOB_ADS_INITALIZED",		( u32 )REVMOB_ADS_INITALIZED );
	state.SetField ( -1, "REVMOB_ADS_FAILED",			( u32 )REVMOB_ADS_FAILED );
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
	#pragma mark Protocol RevMobAdsDelegate
	//================================================================//

	//----------------------------------------------------------------//
	- ( void )revmobAdDidReceive {
		
		if ( self.adType == MOAIRevMobIOS::Get ().FULLSCREEN_INTERSTITIAL ) {
			
			MOAIRevMobIOS::Get ().mHasInterstitial = YES;
		}
	}

	//----------------------------------------------------------------//
	- ( void )revmobRewardedVideoDidLoad {
		
		if ( self.adType == MOAIRevMobIOS::Get ().FULLSCREEN_REWARDED_VIDEO ) {
			
			MOAIRevMobIOS::Get ().mHasRewardedVideo = YES;
		}
	}

	//----------------------------------------------------------------//
	- ( void )revmobRewardedVideoDidFinish {
		
		MOAIRevMobIOS::Get ().InvokeListener ( MOAIRevMobIOS::REWARDED_VIDEO_COMPLETED );
	}

@end
