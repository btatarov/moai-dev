// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef	MOAIFACEBOOKANDROID_H
#define	MOAIFACEBOOKANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIFacebookAndroid
//================================================================//
/**	@lua	MOAIFacebookAndroid
	@text	Wrapper for Facebook integration on Android devices.
			Facebook provides social integration for sharing on
			www.facebook.com. Exposed to Lua via MOAIFacebook on
			all mobile platforms.

	@const	FACEBOOK_LOGIN_SUCCESS		Event code for a successfully completed Facebook login.
	@const	FACEBOOK_LOGIN_CANCEL		Event code for a canceled Facebook login.
	@const	FACEBOOK_LOGIN_ERROR		Event code if an error occured while logging in.
	@const	FACEBOOK_DIALOG_SUCCESS		Event code for a successfully completed Facebook dialog.
	@const	FACEBOOK_DIALOG_CANCEL		Event code for a canceled Facebook dialog.
	@const	FACEBOOK_DIALOG_ERROR		Event code if an error occured while showing the dialog.
*/
class MOAIFacebookAndroid :
	public MOAIGlobalClass < MOAIFacebookAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_GetToken;
	jmethodID	mJava_GetUserID;
	jmethodID	mJava_GraphRequest;
	jmethodID	mJava_InviteFriends;
	jmethodID	mJava_IsUserLoggedIn;
	jmethodID	mJava_Login;
	jmethodID	mJava_Logout;
	jmethodID	mJava_PostToFeed;

	//----------------------------------------------------------------//
	static int	_getToken			( lua_State* L );
	static int	_getUserID			( lua_State* L );
	static int	_graphRequest		( lua_State* L );
	static int	_inviteFriends		( lua_State* L );
	static int	_isUserLoggedIn		( lua_State* L );
	static int	_login				( lua_State* L );
	static int	_logout				( lua_State* L );
	static int	_postToFeed			( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIFacebookAndroid );

	enum {
		FACEBOOK_LOGIN_SUCCESS,
		FACEBOOK_LOGIN_CANCEL,
		FACEBOOK_LOGIN_ERROR,
		FACEBOOK_DIALOG_SUCCESS,
        FACEBOOK_DIALOG_CANCEL,
        FACEBOOK_DIALOG_ERROR,
	};

			MOAIFacebookAndroid		();
			~MOAIFacebookAndroid	();
	void	RegisterLuaClass		( MOAILuaState& state );
};

#endif  //MOAIFACEBOOK_H
