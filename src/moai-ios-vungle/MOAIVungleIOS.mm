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
int MOAIVungleIOS::_hasCachedRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	VungleSDK* sdk = [ VungleSDK sharedSDK ];
	bool hasCachedVideo = [ sdk isAdPlayable ];

	lua_pushboolean ( state, hasCachedVideo );

	return 1;
}

//----------------------------------------------------------------//
int MOAIVungleIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	cc8* appID = lua_tostring ( state, 1 );

	VungleSDK* sdk = [ VungleSDK sharedSDK ];
	[ sdk startWithAppId:[ NSString stringWithUTF8String:appID ] ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIVungleIOS::_showRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );
	
	bool showCloseButton = lua_toboolean ( state, 1 );
	
	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];
	
	VungleSDK* sdk = [ VungleSDK sharedSDK ];
	
	if ( [ sdk isAdPlayable ] ) {
		
		NSError *error; // TODO: Print to console or listener callback?
		if ( showCloseButton ) {
			
			[ sdk playAd:rootVC error:( &error ) ];
		} else {
			
			NSDictionary* options = @{
				VunglePlayAdOptionKeyIncentivized : @YES,
				VunglePlayAdOptionKeyIncentivizedAlertBodyText : @"If the video isn't completed you won't get your reward! Are you sure you want to close early?",
				VunglePlayAdOptionKeyIncentivizedAlertCloseButtonText : @"Close",
				VunglePlayAdOptionKeyIncentivizedAlertContinueButtonText : @"Keep Watching",
				VunglePlayAdOptionKeyIncentivizedAlertTitleText : @"Careful!"
			};
		
			[ sdk playAd:rootVC withOptions:options error:( &error ) ];
		}
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
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIVungleIOS > },
		{ "hasCachedRewardedVideo",	_hasCachedRewardedVideo },
		{ "init",					_init },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIVungleIOS > },
		{ "showRewardedVideo",		_showRewardedVideo },
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
	- ( void )vungleSDKwillCloseAdWithViewInfo:( NSDictionary* )viewInfo willPresentProductSheet:( BOOL )willPresentProductSheet {

		UNUSED ( willPresentProductSheet );
		
		bool completedView = [ viewInfo valueForKey:@"completedView" ];
		
		if ( completedView ) {

			MOAIVungleIOS::Get ().InvokeListener ( MOAIVungleIOS::REWARDED_VIDEO_COMPLETED );
		}
	}

@end
