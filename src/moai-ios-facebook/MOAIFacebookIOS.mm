//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

#import <moai-ios/headers.h>
#import <moai-ios-facebook/MOAIFacebookIOS.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
/**	@lua	init
 @text	Initialize Facebook.

 @in		nil
 @out 	nil
 */
int MOAIFacebookIOS::_init ( lua_State* L ) {

	MOAILuaState state ( L );

	[ FBSDKAppEvents activateApp ];

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	inviteFriends
	@text	Send an app request to the logged in users' friends.
	@in		string	url				The URL that the post links to. See Facebook documentation.

	@opt	string	image			The URL of an image to include in the post. See Facebook documentation.
	@out 	nil
 */
int MOAIFacebookIOS::_inviteFriends ( lua_State* L ) {

	MOAILuaState state ( L );

	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];

	FBSDKAppInviteContent *content   = [ [FBSDKAppInviteContent alloc ] init ];
	content.appLinkURL               = [ NSURL URLWithString:[ NSString stringWithUTF8String:state.GetValue < cc8* > ( 1, "" ) ] ];
	content.appInvitePreviewImageURL = [ NSURL URLWithString:[ NSString stringWithUTF8String:state.GetValue < cc8* > ( 2, "" ) ] ];

	[ FBSDKAppInviteDialog showFromViewController:rootVC
	                                  withContent:content
                        delegate:MOAIFacebookIOS::Get ().mAppInviteDelegate
    ];

	[ content release ];

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	login
 @text	Prompt the user to login to Facebook.

 @opt	table	permissions		Optional set of required permissions. See Facebook documentation for a full list. Default is nil.
 @out 	nil
 */
int MOAIFacebookIOS::_login ( lua_State* L ) {

	MOAILuaState state ( L );

	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];

	FBSDKLoginManager* loginMgr = [ [ FBSDKLoginManager alloc ] init ];

	NSMutableDictionary* paramsDict = [ [ NSMutableDictionary alloc ] init ];

	if ( state.IsType ( 1, LUA_TTABLE )) {
		[ paramsDict initWithLua:state stackIndex:1 ];
	}

	NSMutableArray* perms = [ [ NSMutableArray alloc ] initWithObjects:[ paramsDict allValues ], nil ];
	[ perms addObject:@"public_profile" ];
	[ perms addObject:@"email" ];

	[ loginMgr logInWithReadPermissions:perms fromViewController:rootVC
	 handler:^( FBSDKLoginManagerLoginResult *result, NSError *error ) {

		if ( error ) {

			MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::LOGIN_ERROR );
		} else if (result.isCancelled) {

			MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::LOGIN_DISMISSED );
		 } else {

			MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::LOGIN_SUCCESSFUL );
		}
  }];

	[ perms release ];
	[ paramsDict release ];
	[ loginMgr release ];

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	logout
 @text	Log the user out of Facebook.

 @in		nil
 @out 	nil
 */
int MOAIFacebookIOS::_logout ( lua_State* L ) {

	FBSDKLoginManager* loginMgr = [ [ FBSDKLoginManager alloc ] init ];
	[ loginMgr logOut ];
	[ loginMgr release ];

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	postToFeed
 @text	Post a message to the logged in users' news feed.

 @in		string	url				The URL that the post links to. See Facebook documentation.
 @in		string	image			The URL of an image to include in the post. See Facebook documentation.
 @in		string	title			The name of the link. See Facebook documentation.

 @in		string	description		The description of the link. See Facebook documentation.
 @out 	nil
 */
int MOAIFacebookIOS::_postToFeed ( lua_State* L ) {

	MOAILuaState state ( L );

	// root view controller
	UIWindow* window = [ [ UIApplication sharedApplication ] keyWindow ];
	UIViewController* rootVC = [ window rootViewController ];

	// content to share
	FBSDKShareLinkContent *content = [ [ FBSDKShareLinkContent alloc ] init ];

	content.contentURL          = [ NSURL URLWithString:[ NSString stringWithUTF8String:state.GetValue < cc8* > ( 1, "" ) ] ];
	content.imageURL            = [ NSURL URLWithString:[ NSString stringWithUTF8String:state.GetValue < cc8* > ( 2, "" ) ] ];
	content.contentTitle        = [ NSString stringWithUTF8String:state.GetValue < cc8* > ( 3, "" ) ];
	content.contentDescription  = [ NSString stringWithUTF8String:state.GetValue < cc8* > ( 4, "" ) ];

	// share dialog
	[ FBSDKShareDialog showFromViewController:rootVC withContent:content delegate:nil ];

	FBSDKShareDialog *dialog = [ [FBSDKShareDialog alloc ] init ];
	dialog.fromViewController = rootVC;
	dialog.shareContent = content;
	dialog.mode = FBSDKShareDialogModeShareSheet;
	dialog.delegate = MOAIFacebookIOS::Get ().mShareDelegate;
	[ dialog show ];

	[ dialog release ];
	[ content release ];

	return 0;
}

//================================================================//
// MOAIFacebookIOS
//================================================================//

//----------------------------------------------------------------//
MOAIFacebookIOS::MOAIFacebookIOS () {

	RTTI_SINGLE ( MOAILuaObject )

	mShareDelegate = [ [ MoaiFacebookShareDelegate alloc ] init ];
	mAppInviteDelegate = [ [ MoaiFacebookAppInviteDelegate alloc ] init ];
}

//----------------------------------------------------------------//
MOAIFacebookIOS::~MOAIFacebookIOS () {

	[ mShareDelegate release ];
    [ mAppInviteDelegate release ];
}

//----------------------------------------------------------------//
void MOAIFacebookIOS::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "LOGIN_SUCCESSFUL",    ( u32 )LOGIN_SUCCESSFUL );
	state.SetField ( -1, "LOGIN_ERROR",         ( u32 )LOGIN_ERROR );
	state.SetField ( -1, "LOGIN_DISMISSED",     ( u32 )LOGIN_DISMISSED );

	state.SetField ( -1, "SHARE_SUCCESSFUL", 	( u32 )SHARE_SUCCESSFUL );
	state.SetField ( -1, "SHARE_ERROR",         ( u32 )SHARE_ERROR );
	state.SetField ( -1, "SHARE_DISMISSED",     ( u32 )SHARE_DISMISSED );

	state.SetField ( -1, "INVITE_SUCCESSFUL",   ( u32 )INVITE_SUCCESSFUL );
	state.SetField ( -1, "INVITE_ERROR",        ( u32 )INVITE_ERROR );

	luaL_Reg regTable[] = {
		{ "getListener",				&MOAIGlobalEventSource::_getListener < MOAIFacebookIOS > },
		{ "init",						_init },
		{ "login",						_login },
		{ "logout",						_logout },
		{ "postToFeed",					_postToFeed },
		{ "inviteFriends",				_inviteFriends },
		{ "setListener",				&MOAIGlobalEventSource::_setListener < MOAIFacebookIOS > },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// MoaiFacebookShareDelegate
//================================================================//
@implementation MoaiFacebookShareDelegate

	//================================================================//
	#pragma mark -
	#pragma mark Protocol MoaiFacebookShareDelegate
	//================================================================//

	//----------------------------------------------------------------//
	- ( void ) sharer:( id < FBSDKSharing > )sharer didCompleteWithResults:( NSDictionary* )results {

		UNUSED ( sharer );
		UNUSED ( results );

		MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::SHARE_SUCCESSFUL );
	}

	- ( void ) sharer:( id < FBSDKSharing > )sharer didFailWithError:( NSError* )error {

		UNUSED ( sharer );
		UNUSED (error );

		MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::SHARE_ERROR );
	}

	- ( void ) sharerDidCancel:( id < FBSDKSharing > )sharer {

		UNUSED ( sharer );

		MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::SHARE_DISMISSED );
	}

@end

@implementation MoaiFacebookAppInviteDelegate

	//================================================================//
	#pragma mark -
	#pragma mark Protocol MoaiFacebookAppInviteDelegate
	//================================================================//

	//----------------------------------------------------------------//
    - ( void ) appInviteDialog:(FBSDKAppInviteDialog *)appInviteDialog didCompleteWithResults:(NSDictionary *)results {

		UNUSED ( appInviteDialog );
		UNUSED ( results );

		MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::INVITE_SUCCESSFUL );
	}

	//----------------------------------------------------------------//
	- ( void ) appInviteDialog:	( FBSDKAppInviteDialog* )appInviteDialog
			  didFailWithError:	(NSError *)error {

		UNUSED (error );

		MOAIFacebookIOS::Get ().InvokeListener ( MOAIFacebookIOS::INVITE_ERROR );
	}
@end
