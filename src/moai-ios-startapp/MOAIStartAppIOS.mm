//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios-startapp/MOAIStartAppIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIStartAppIOS::_cacheBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	// UNUSED

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_cacheInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	STAStartAppAd* interstitial = MOAIStartAppIOS::Get ().mInterstitial;
	[ interstitial loadAd ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_hasCachedBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	bool isBannerAvailable = MOAIStartAppIOS::Get ().mHasCachedBanner;

	lua_pushboolean ( state, isBannerAvailable );

	return 1;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_hasCachedInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	STAStartAppAd* interstitial = MOAIStartAppIOS::Get ().mInterstitial;
	bool isAdAvailable = [ interstitial isReady ];

	lua_pushboolean ( state, isAdAvailable );

	return 1;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_hideBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	STABannerView* bannerView = MOAIStartAppIOS::Get ().mBannerView;
	[ bannerView hideBanner ];

	return 1;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* appID = lua_tostring ( state, 1 );
	bool showReturnAds = lua_toboolean ( state, 2 );

	STAStartAppSDK* sdk = [ STAStartAppSDK sharedInstance ];
	sdk.appID = [ NSString stringWithUTF8String:appID ];

	[ MOAIStartAppIOS::Get ().mInterstitial init ];

	if ( ! showReturnAds ) [ sdk disableReturnAd ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_initBannerWithParams ( lua_State* L ) {

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

	MoaiStartAppContainerView* container = [ MOAIStartAppIOS::Get ().mContainerView initWithFrame:containerRect ];
	[ rootVC.view addSubview:container ];

	STAAdOrigin origin;
	if ( atBottom ) origin = STAAdOrigin_Top;
	else origin = STAAdOrigin_Bottom;

	STABannerView* bannerView = MOAIStartAppIOS::Get ().mBannerView;
	[ bannerView initWithSize:STA_AutoAdSize autoOrigin:origin withView:container withDelegate:MOAIStartAppIOS::Get ().mContainerView ];
	[ bannerView hideBanner ];

	[ container addSubview:bannerView ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_showBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	STABannerView* bannerView = MOAIStartAppIOS::Get ().mBannerView;

	if ( MOAIStartAppIOS::Get ().mHasCachedBanner ) {

		[ bannerView showBanner ];
	}

	return 1;
}

//----------------------------------------------------------------//
int MOAIStartAppIOS::_showInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	STAStartAppAd* interstitial = MOAIStartAppIOS::Get ().mInterstitial;

	if ( [ interstitial isReady ] ) {

		[ interstitial showAd ];
	}

	return 1;
}

//================================================================//
// MOAIStartAppIOS
//================================================================//

//----------------------------------------------------------------//
MOAIStartAppIOS::MOAIStartAppIOS () {

	RTTI_SINGLE ( MOAILuaObject )

	mBannerView = [ STABannerView alloc ];
	mContainerView = [ MoaiStartAppContainerView alloc ];
	mInterstitial = [ STAStartAppAd alloc ];
}

//----------------------------------------------------------------//
MOAIStartAppIOS::~MOAIStartAppIOS () {

	//[ mBannerView release ];
	[ mContainerView release ];
	[ mInterstitial release ];
}

//----------------------------------------------------------------//
void MOAIStartAppIOS::RegisterLuaClass ( MOAILuaState& state ) {

	luaL_Reg regTable [] = {
		{ "cacheBanner",			_cacheBanner },
		{ "cacheInterstitial",		_cacheInterstitial },
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIStartAppIOS > },
		{ "hasCachedInterstitial",	_hasCachedInterstitial },
		{ "hasCachedBanner",		_hasCachedBanner },
		{ "hideBanner",				_hideBanner },
		{ "init",					_init },
		{ "initBannerWithParams",	_initBannerWithParams },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIStartAppIOS > },
		{ "showInterstitial",		_showInterstitial },
		{ "showBanner",				_showBanner },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// MoaiStartAppContainerView
//================================================================//
@implementation MoaiStartAppContainerView

//================================================================//
#pragma mark -
#pragma mark Protocol STABannerDelegateProtocol
//================================================================//

//----------------------------------------------------------------//
- ( void ) didDisplayBannerAd:( STABannerView* )banner {

	UNUSED ( banner );

	MOAIStartAppIOS::Get ().mHasCachedBanner = YES;
}

//----------------------------------------------------------------//
- ( void ) failedLoadBannerAd:( STABannerView* )banner withError:( NSError* )error {

	UNUSED ( banner );
	UNUSED ( error );

	MOAIStartAppIOS::Get ().mHasCachedBanner = NO;
}

@end
