//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef	MOAIVUNGLEIOS_H
#define	MOAIVUNGLEIOS_H

#include <moai-core/headers.h>
#import <VungleSDK/VungleSDK.h>

@class MoaiVungleDelegate;

//================================================================//
// MOAIVungleIOS
//================================================================//
class MOAIVungleIOS :
	public MOAIGlobalClass < MOAIVungleIOS, MOAIGlobalEventSource > {
private:

	MoaiVungleDelegate*	mDelegate;

	//----------------------------------------------------------------//
	static int		_hasCachedRewardedVideo			( lua_State* L );
	static int		_init							( lua_State* L );
	static int		_showRewardedVideo				( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIVungleIOS );

	enum {
		REWARDED_VIDEO_COMPLETED,
		TOTAL
	};

	//----------------------------------------------------------------//
					MOAIVungleIOS					();
					~MOAIVungleIOS					();
	void 			NotifyInterstitialDismissed		();
	void 			NotifyInterstitialLoadFailed	();
	void			RegisterLuaClass				( MOAILuaState& state );
};

//================================================================//
// MoaiVungleDelegate
//================================================================//
@interface MoaiVungleDelegate : NSObject < VungleSDKDelegate > {
@private
}
@end

#endif  //MOAIVUNGLEIOS_H
