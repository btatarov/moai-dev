//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef MOAIADCOLONYIOS_H
#define MOAIADCOLONYIOS_H

#include <moai-core/headers.h>

#import <AdColony/AdColony.h>

//================================================================//
// MOAIAdColonyIOS
//================================================================//
class MOAIAdColonyIOS :
public MOAIGlobalClass < MOAIAdColonyIOS, MOAILuaObject >,
public MOAIGlobalEventSource {
private:

	//----------------------------------------------------------------//
	static int		_cacheRewardedVideo			( lua_State* L );
	static int		_hasCachedRewardedVideo		( lua_State* L );
	static int		_init						( lua_State* L );
	static int		_showRewardedVideo			( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIAdColonyIOS );

	enum {
		REWARDED_VIDEO_COMPLETED,
		REWARDED_VIDEO_FAILED,
	};

	AdColonyInterstitial 	*mInterstitial;

	//----------------------------------------------------------------//
					MOAIAdColonyIOS					();
					~MOAIAdColonyIOS				();
	void			RegisterLuaClass				( MOAILuaState& state );
};

#endif // MOAIADCOLONYIOS_H
