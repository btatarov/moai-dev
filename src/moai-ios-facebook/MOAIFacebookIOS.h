//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#ifndef MOAIFACEBOOKIOS_H
#define MOAIFACEBOOKIOS_H

#import <Foundation/Foundation.h>
#import <moai-core/headers.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>

@class MoaiFacebookShareDelegate;
@class MoaiFacebookAppInviteDelegate;

//================================================================//
// MOAIFacebookIOS
//================================================================//
/**	@lua	MOAIFacebookIOS
	@text	Wrapper for Facebook integration on iOS devices.
			Facebook provides social integration for sharing on
			www.facebook.com. Exposed to Lua via MOAIFacebook on
			all mobile platforms.
 TODO:doxygen
*/
class MOAIFacebookIOS :
	public MOAIGlobalClass < MOAIFacebookIOS, MOAILuaObject >,
	public MOAIGlobalEventSource {
private:

	MoaiFacebookShareDelegate* mShareDelegate;
	MoaiFacebookAppInviteDelegate* mAppInviteDelegate;

	//----------------------------------------------------------------//
	static int		_getToken					( lua_State* L );
	static int		_getUserID					( lua_State* L );
	static int		_inviteFriends				( lua_State* L );
	static int		_isUserLoggedIn				( lua_State* L );
	static int		_login						( lua_State* L );
	static int		_logout						( lua_State* L );
	static int		_postToFeed					( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIFacebookIOS );

	enum {
		FACEBOOK_LOGIN_SUCCESS,
		FACEBOOK_LOGIN_CANCEL,
		FACEBOOK_LOGIN_ERROR,
		SHARE_SUCCESSFUL,
		SHARE_ERROR,
		SHARE_DISMISSED,
		INVITE_SUCCESSFUL,
		INVITE_ERROR
	};

	//----------------------------------------------------------------//
				MOAIFacebookIOS			        ();
				~MOAIFacebookIOS		        ();
	void		RegisterLuaClass		        ( MOAILuaState& state );
};

//================================================================//
// Moai Facebook Delegates
//================================================================//
@interface MoaiFacebookShareDelegate : NSObject < FBSDKSharingDelegate > {
@private
}
@end

@interface MoaiFacebookAppInviteDelegate : NSObject < FBSDKAppInviteDialogDelegate > {
@private
}
@end

#endif // MOAIFACEBOOK_H
