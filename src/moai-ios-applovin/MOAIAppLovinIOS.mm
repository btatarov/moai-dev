//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios-applovin/MOAIAppLovinIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIAppLovinIOS::_cacheRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	[ ALIncentivizedInterstitialAd preloadAndNotify: nil ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIAppLovinIOS::_hasCachedInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	bool isAdAvailable = [ ALInterstitialAd isReadyForDisplay ];

	lua_pushboolean ( state, isAdAvailable );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAppLovinIOS::_hasCachedRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	bool isAdAvailable = [ ALIncentivizedInterstitialAd isReadyForDisplay ];

	lua_pushboolean ( state, isAdAvailable );

	return 1;
}

//----------------------------------------------------------------//
int MOAIAppLovinIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	[ ALSdk initializeSdk ];

	return 0;
}

//----------------------------------------------------------------//
int MOAIAppLovinIOS::_showInterstitial ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( [ ALInterstitialAd isReadyForDisplay ] ) {

		[ ALInterstitialAd show ];

		lua_pushboolean ( state, true );
		return 1;
	}

	lua_pushboolean ( state, false );
	return 1;
}

//----------------------------------------------------------------//
int MOAIAppLovinIOS::_showRewardedVideo ( lua_State* L ) {

	MOAILuaState state ( L );

	if ( [ ALIncentivizedInterstitialAd isReadyForDisplay ] ) {

    	[ ALIncentivizedInterstitialAd showAndNotify: nil ];

		lua_pushboolean ( state, true );
		return 1;
	}

	lua_pushboolean ( state, false );
	return 1;
}

//================================================================//
// MOAIAppLovinIOS
//================================================================//

//----------------------------------------------------------------//
MOAIAppLovinIOS::MOAIAppLovinIOS () {

	RTTI_SINGLE ( MOAILuaObject )

	mDelegate = [[ MoaiAppLovinDelegate alloc ] init ];
}

//----------------------------------------------------------------//
MOAIAppLovinIOS::~MOAIAppLovinIOS () {

	[ mDelegate release ];
}

//----------------------------------------------------------------//
void MOAIAppLovinIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "REWARDED_VIDEO_COMPLETED",	( u32 )REWARDED_VIDEO_COMPLETED );

	luaL_Reg regTable [] = {
		{ "cacheRewardedVideo",		_cacheRewardedVideo },
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIAppLovinIOS > },
		{ "hasCachedInterstitial",	_hasCachedInterstitial },
		{ "hasCachedRewardedVideo",	_hasCachedRewardedVideo },
		{ "init",					_init },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIAppLovinIOS > },
		{ "showInterstitial",		_showInterstitial },
		{ "showRewardedVideo",		_showRewardedVideo },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// MoaiAppLovinDelegate
//================================================================//
@implementation MoaiAppLovinDelegate

	//================================================================//
	#pragma mark -
	#pragma mark Protocol MoaiAppLovinDelegate
	//================================================================//

	//----------------------------------------------------------------//
	- ( void ) videoPlaybackEndedInAd:( ALAd* )ad atPlaybackPercent:( NSNumber* )percentPlayed fullyWatched:( BOOL )wasFullyWatched {

		UNUSED ( ad );
		UNUSED ( percentPlayed );

		if ( wasFullyWatched ) {

			MOAIAppLovinIOS::Get ().InvokeListener ( MOAIAppLovinIOS::REWARDED_VIDEO_COMPLETED );
		}
	}

@end
