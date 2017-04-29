//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef	MOAIAPPLOVINIOS_H
#define	MOAIAPPLOVINIOS_H

#include <moai-core/headers.h>
#import <AppLovinSDK/AppLovinSDK.h>

@class MoaiAppLovinDelegate;

//================================================================//
// MOAIAppLovinIOS
//================================================================//
class MOAIAppLovinIOS :
	public MOAIGlobalClass < MOAIAppLovinIOS, MOAIGlobalEventSource > {
private:

	MoaiAppLovinDelegate*	mDelegate;

	//----------------------------------------------------------------//
	static int		_cacheRewardedVideo				( lua_State* L );
	static int		_hasCachedInterstitial			( lua_State* L );
	static int		_hasCachedRewardedVideo			( lua_State* L );
	static int		_init							( lua_State* L );
	static int		_showInterstitial				( lua_State* L );
	static int		_showRewardedVideo				( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIAppLovinIOS );

	enum {
		REWARDED_VIDEO_COMPLETED,
		TOTAL
	};

	//----------------------------------------------------------------//
					MOAIAppLovinIOS					();
					~MOAIAppLovinIOS				();
	void 			NotifyInterstitialDismissed		();
	void 			NotifyInterstitialLoadFailed	();
	void			RegisterLuaClass				( MOAILuaState& state );
};

//================================================================//
// MoaiAppLovinDelegate
//================================================================//
@interface MoaiAppLovinDelegate : NSObject < ALAdVideoPlaybackDelegate > {
@private
}
@end

#endif  //MOAIAPPLOVINIOS_H
