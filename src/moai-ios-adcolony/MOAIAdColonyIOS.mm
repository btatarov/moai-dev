//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios-adcolony/MOAIAdColonyIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
/**	@lua	cacheRewardedVideo
	@text	Cache an AdColony video ad.

	@in 	string	zone			The zone from which to cache a video ad.
	@out 	nil
*/
int MOAIAdColonyIOS::_cacheRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* zone = lua_tostring ( state, 1 );

	[ AdColony requestInterstitialInZone:[ NSString stringWithUTF8String:zone ] options:nil success: ^( AdColonyInterstitial * ad ) {

        ad.close = ^{
            MOAIAdColonyIOS::Get ().mInterstitial = nil;
        };

        ad.expire = ^{
            MOAIAdColonyIOS::Get ().mInterstitial = nil;
        };

        MOAIAdColonyIOS::Get ().mInterstitial = ad;
    } failure:nil ];

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	hasCachedRewardedVideo
	@text	Check the readiness of a video ad.

	@out 	bool					True, if a video ad is ready to play.
*/
int MOAIAdColonyIOS::_hasCachedRewardedVideo ( lua_State *L ) {

	MOAILuaState state ( L );

	bool ready = ( MOAIAdColonyIOS::Get ().mInterstitial && ! MOAIAdColonyIOS::Get ().mInterstitial.expired ) ? true : false;

	lua_pushboolean ( L, ready );

	return 1;
}

//----------------------------------------------------------------//
/**	@lua	init
	@text	Initialize AdColony.

	@in		string	appId			Available in AdColony dashboard settings.
	@in 	table	zone_list		A list of zones to configure. Available in AdColony dashboard settings.
	@out 	nil
*/
int MOAIAdColonyIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* appID		= state.GetValue < cc8* >( 1, "" );

	NSMutableArray* zone_list = [ [ [ NSMutableArray alloc ] init ] autorelease ];
	if ( state.IsType ( 2, LUA_TTABLE ) ) {
		for ( int key = 1; ; ++key ) {
			state.GetField ( 2, key );
			cc8* value = state.GetValue < cc8* >( -1, 0 );
			lua_pop ( state, 1 );

			if ( value ) {
				[ zone_list addObject:[ NSString stringWithUTF8String:value ] ];
			} else {
				break;
			}
		}
	}

	AdColonyAppOptions *options;
	options = [ [ [ AdColonyAppOptions alloc ] init ] autorelease ];
	options.disableLogging = YES;

	[ AdColony configureWithAppID:[ NSString stringWithUTF8String:appID ] zoneIDs:zone_list options:options completion: ^( NSArray < AdColonyZone * > * zones ) {

        AdColonyZone *zone = [ zones firstObject ];
        zone.reward = ^( BOOL success, NSString *name, int amount ) {

			UNUSED ( name );
			UNUSED ( amount );

			u32 eventID = success ? MOAIAdColonyIOS::REWARDED_VIDEO_COMPLETED : MOAIAdColonyIOS::REWARDED_VIDEO_FAILED;
			MOAIAdColonyIOS::Get ().InvokeListener (( u32 )eventID );
        };
    } ];

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	showRewardedVideo
	@text	Play an AdColony video ad.

	@out 	nil
*/
int MOAIAdColonyIOS::_showRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( MOAIAdColonyIOS::Get ().mInterstitial && ! MOAIAdColonyIOS::Get ().mInterstitial.expired ) {

		// root view controller
		UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
		UIViewController* rootVC = [ window rootViewController ];

		[ MOAIAdColonyIOS::Get ().mInterstitial showWithPresentingViewController:rootVC ];
	}

	return 0;
}

//================================================================//
// MOAIAdColonyIOS
//================================================================//

//----------------------------------------------------------------//
MOAIAdColonyIOS::MOAIAdColonyIOS () {

	RTTI_SINGLE ( MOAILuaObject )
}

//----------------------------------------------------------------//
MOAIAdColonyIOS::~MOAIAdColonyIOS () {

}

//----------------------------------------------------------------//
void MOAIAdColonyIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED",	( u32 )REWARDED_VIDEO_COMPLETED );
	state.SetField ( -1, "REWARDED_VIDEO_FAILED",		( u32 )REWARDED_VIDEO_FAILED );

	luaL_Reg regTable [] = {
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIAdColonyIOS > },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIAdColonyIOS > },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register( state, 0, regTable );
}
