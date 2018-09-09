//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios-vungle/MOAIVungleIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIVungleIOS::_cacheRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* placement = lua_tostring ( state, 1 );

	VungleSDK* sdk = [ VungleSDK sharedSDK ];
	NSError* error;

	[ sdk loadPlacementWithID:[ NSString stringWithUTF8String:placement ] error:&error ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIVungleIOS::_hasCachedRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* placement = lua_tostring ( state, 1 );

	VungleSDK* sdk = [ VungleSDK sharedSDK ];

	bool ready = [ sdk isAdCachedForPlacementID:[ NSString stringWithUTF8String:placement ] ];

	lua_pushboolean ( L, ready );

	return 1;
}

//----------------------------------------------------------------//
int MOAIVungleIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* appID = lua_tostring ( state, 1 );

	NSMutableArray* placements = [ [ [ NSMutableArray alloc ] init ] autorelease ];
	if ( state.IsType ( 2, LUA_TTABLE ) ) {
		for ( int key = 1; ; ++key ) {
			state.GetField ( 2, key );
			cc8* value = state.GetValue < cc8* >( -1, 0 );
			lua_pop ( state, 1 );

			if ( value ) {
				[ placements addObject:[ NSString stringWithUTF8String:value ] ];
			} else {
				break;
			}
		}
	}

	VungleSDK* sdk = [ VungleSDK sharedSDK ];
	[ sdk setDelegate:MOAIVungleIOS::Get ().mDelegate ];
	[ sdk setLoggingEnabled:NO ];
	NSError *error = nil;

	[ sdk startWithAppId:[ NSString stringWithUTF8String:appID ] placements:placements error:&error ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIVungleIOS::_showRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* placement = lua_tostring ( state, 1 );

	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];

	VungleSDK* sdk = [ VungleSDK sharedSDK ];
	NSError *error;

	if ( [ sdk isAdCachedForPlacementID:[ NSString stringWithUTF8String:placement ] ] ) {

		[ sdk playAd:rootVC options:nil placementID:[ NSString stringWithUTF8String:placement ] error:&error];
	}

	return 0;
}

//================================================================//
// MOAIVungleIOS
//================================================================//

//----------------------------------------------------------------//
MOAIVungleIOS::MOAIVungleIOS () {

	RTTI_SINGLE ( MOAILuaObject )

	mDelegate = [ [ MoaiVungleDelegate alloc ] init ];
}

//----------------------------------------------------------------//
MOAIVungleIOS::~MOAIVungleIOS () {

	[ mDelegate release ];
}

//----------------------------------------------------------------//
void MOAIVungleIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED", 	( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheRewardedVideo",			_cacheRewardedVideo },
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIVungleIOS > },
		{ "hasCachedRewardedVideo",		_hasCachedRewardedVideo },
		{ "init",						_init },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIVungleIOS > },
		{ "showRewardedVideo",			_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// MoaiVungleDelegate
//================================================================//
@implementation MoaiVungleDelegate

	//================================================================//
	#pragma mark -
	#pragma mark Protocol MoaiVungleDelegate
	//================================================================//

	//----------------------------------------------------------------//
	- ( void )vungleWillCloseAdWithViewInfo:( VungleViewInfo* )viewInfo placementID:( NSString * )placementID {

		UNUSED ( placementID );

		if ( viewInfo.completedView ) {

			MOAIVungleIOS::Get ().InvokeListener ( MOAIVungleIOS::REWARDED_VIDEO_COMPLETED );
		}
	}

@end
