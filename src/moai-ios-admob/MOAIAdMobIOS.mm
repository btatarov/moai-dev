//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios-admob/MOAIAdMobIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIAdMobIOS::_cacheBanner ( lua_State* L ) {

	MOAILuaState state ( L );
	
	GADBannerView* bannerView = MOAIAdMobIOS::Get ().mBannerView;
	
	GADRequest* request = [ GADRequest request ];
	// request.testDevices = @[ @"your_device_id" ];
	
	[ bannerView loadRequest:request ];
	
	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_cacheInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );
	
	GADInterstitial* interstitial = MOAIAdMobIOS::Get ().mInterstitial;
	
	GADRequest* request = [ GADRequest request ];
	// request.testDevices = @[ @"your_device_id" ];
	
	[ interstitial loadRequest:request ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_hasCachedBanner ( lua_State* L ) {

	MOAILuaState state ( L );

	bool isBannerAvailable = MOAIAdMobIOS::Get ().mHasCachedBanner;

	lua_pushboolean ( state, isBannerAvailable );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_hasCachedInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	GADInterstitial* interstitial = MOAIAdMobIOS::Get ().mInterstitial;
	bool isAdAvailable = [ interstitial isReady ];

	lua_pushboolean ( state, isAdAvailable );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_hideBanner ( lua_State* L ) {

	MOAILuaState state ( L );
	
	MOAIAdMobIOS::Get ().mBannerView.hidden = YES;

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );
	
	cc8* unitID = lua_tostring ( state, 1 );
	
	GADInterstitial* interstitial = MOAIAdMobIOS::Get ().mInterstitial;
	[ interstitial initWithAdUnitID:[ NSString stringWithUTF8String:unitID ] ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_initBannerWithParams ( lua_State* L ) {
	
	MOAILuaState state ( L );
	
	cc8*	unitID		= lua_tostring ( state, 1 );
	u32		margin		= lua_tonumber ( state, 2 );
	BOOL	atBottom	= lua_toboolean ( state, 3 );
	
	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];
	
	// wrapper bounds
	CGRect screenRect = [[ UIScreen mainScreen ] bounds ];
	CGRect containerRect = CGRectMake ( 0, 0, screenRect.size.width, screenRect.size.height );

	MoaiAdMobContainerView* container = MOAIAdMobIOS::Get ().mContainerView;
	[ container initWithFrame:containerRect ];
	container.opaque = NO;
	container.backgroundColor = [ UIColor clearColor ];
	container.atBottom = atBottom;
	container.margin = margin;
	container.alreadyPositioned = NO;
	
	[ rootVC.view addSubview:container ];
	
	GADBannerView* bannerView = MOAIAdMobIOS::Get ().mBannerView;
	
	UIDeviceOrientation orientation = [ [ UIDevice currentDevice ] orientation ];
	
	if ( orientation == UIInterfaceOrientationPortrait ||
	     orientation == UIInterfaceOrientationPortraitUpsideDown ) {
		
		[ bannerView initWithAdSize:kGADAdSizeSmartBannerPortrait ];
		
	} else {
	
		[ bannerView initWithAdSize:kGADAdSizeSmartBannerLandscape ];
	}
	
	bannerView.hidden = YES;
	bannerView.adUnitID = [ NSString stringWithUTF8String:unitID ];
	bannerView.delegate = MOAIAdMobIOS::Get ().mBannerDelegate;
	bannerView.rootViewController = rootVC;
	
	[ container addSubview:bannerView ];
	
	return 0;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_showBanner ( lua_State* L ) {

	MOAILuaState state ( L );
	
	GADBannerView* bannerView = MOAIAdMobIOS::Get ().mBannerView;
	
	if ( MOAIAdMobIOS::Get ().mHasCachedBanner ) {
		
		bannerView.hidden = NO;
		MOAIAdMobIOS::Get ().mHasCachedBanner = NO;
	}

	return 1;
}

//----------------------------------------------------------------//
int MOAIAdMobIOS::_showInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );
	
	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];
	
	GADInterstitial* interstitial = MOAIAdMobIOS::Get ().mInterstitial;
	
	if ( [ interstitial isReady ] ) {
		
		[ interstitial presentFromRootViewController:rootVC ];
	}

	return 1;
}

//================================================================//
// MOAIAdMobIOS
//================================================================//

//----------------------------------------------------------------//
MOAIAdMobIOS::MOAIAdMobIOS () {

	RTTI_SINGLE ( MOAILuaObject )
	
	mBannerView = [ GADBannerView alloc ];
	mBannerDelegate = [ [ MoaiAdMobBannerDelegate alloc ] init ];
	mContainerView = [ MoaiAdMobContainerView alloc ];
	mInterstitial = [ GADInterstitial alloc ];
}

//----------------------------------------------------------------//
MOAIAdMobIOS::~MOAIAdMobIOS () {

	[ mBannerView release ];
	[ mBannerDelegate release ];
	[ mContainerView release ];
	[ mInterstitial release ];
}

//----------------------------------------------------------------//
void MOAIAdMobIOS::RegisterLuaClass ( MOAILuaState& state ) {

	luaL_Reg regTable [] = {
		{ "cacheBanner",			_cacheBanner },
		{ "cacheInterstitial",		_cacheInterstitial },
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIAdMobIOS > },
		{ "hasCachedInterstitial",	_hasCachedInterstitial },
		{ "hasCachedBanner",		_hasCachedBanner },
		{ "hideBanner",				_hideBanner },
		{ "init",					_init },
		{ "initBannerWithParams",	_initBannerWithParams },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIAdMobIOS > },
		{ "showInterstitial",		_showInterstitial },
		{ "showBanner",				_showBanner },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// MoaiAdMobContainerView
//================================================================//
@implementation MoaiAdMobContainerView

-( id )hitTest:( CGPoint )point withEvent:( UIEvent * )event {
	
	id hitView = [ super hitTest:point withEvent:event ];
	
	if (hitView == self) return nil;
	else return hitView;
}

@end

//================================================================//
// MoaiAdMobBannerDelegate
//================================================================//
@implementation MoaiAdMobBannerDelegate

	//================================================================//
	#pragma mark -
	#pragma mark Protocol MoaiAdMobBannerDelegate
	//================================================================//

	//----------------------------------------------------------------//
	- ( void )adViewDidReceiveAd:( GADBannerView* )adView {
	
		MoaiAdMobContainerView* container = MOAIAdMobIOS::Get ().mContainerView;
		
		// as banners are always the same size, position it only the first time
		if ( ! container.alreadyPositioned ) {
			
			CGRect screenRect = [[ UIScreen mainScreen ] bounds ];
			CGFloat scale = [[ UIScreen mainScreen ] scale ];
			CGFloat screenHeight = screenRect.size.height;
				
			CGRect viewFrame = container.frame;
			
			if ( container.atBottom ) {
				viewFrame.origin.y = screenHeight - adView.frame.size.height - container.margin / scale;
			} else {
				viewFrame.origin.y = container.margin / scale;
			}
			
			[ container setFrame:viewFrame ];
			container.alreadyPositioned = YES;
		}
		
		MOAIAdMobIOS::Get ().mHasCachedBanner = YES;
	}

@end
