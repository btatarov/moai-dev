// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <jni.h>

#include <moai-android/moaiext-jni.h>
#include <moai-android-facebook/MOAIFacebookAndroid.h>

extern JavaVM* jvm;

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
/**	@lua	getToken
	@text	Retrieve the Facebook login token.

	@out	string	token
*/
int MOAIFacebookAndroid::_getToken ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	jstring jtoken = ( jstring )self->CallStaticObjectMethod ( self->mJava_GetToken );
	cc8* token = self->GetCString ( jtoken );

	lua_pushstring ( state, token );

	self->ReleaseCString ( jtoken, token );

	return 1;
}

//----------------------------------------------------------------//
/**	@lua	getUserID
	@text	Retrieve the Facebook user ID.

	@out	string	userID
*/
int MOAIFacebookAndroid::_getUserID ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	jstring juserID = ( jstring )self->CallStaticObjectMethod ( self->mJava_GetUserID );
	cc8* userID = self->GetCString ( juserID );

	lua_pushstring ( state, userID );

	self->ReleaseCString ( juserID, userID );

	return 1;
}

//----------------------------------------------------------------//
/**	@lua	graphRequest
    @text	Make a request on Facebook's Graph API

	@in		string  path
	@opt	table  parameters
    @out	nil
*/
int MOAIFacebookAndroid::_graphRequest ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	// TODO:
	// jstring jpath = self->GetJString ( lua_tostring ( state, 1 ));

    //jobject bundle;
    //if ( state.IsType ( 2, LUA_TTABLE ) ) {
    //    bundle = self->BundleFromLua( L, 2 );
    //}

	//self->CallStaticVoidMethod ( self->mJava_GraphRequest, jpath, bundle );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	inviteFriends
	@text	Send an app request to the logged in user's friends.

	@in		string	url				The URL that the invite links to. See Facebook documentation.
	@in		string	img				The URL of an image to include in the invite. See Facebook documentation.
	@out 	nil
*/
int MOAIFacebookAndroid::_inviteFriends ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	jstring jurl = self->GetJString ( lua_tostring ( state, 1 ));
	jstring jimg = self->GetJString ( lua_tostring ( state, 2 ));

	self->CallStaticVoidMethod ( self->mJava_InviteFriends, jurl, jimg );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	isUserLoggedIn
	@text	Determine whether or not the user is (still) logged in.

	@out 	boolean
*/
int MOAIFacebookAndroid::_isUserLoggedIn ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	lua_pushboolean ( state, self->CallStaticBooleanMethod ( self->mJava_IsUserLoggedIn ) );

	return 1;
}

//----------------------------------------------------------------//
/**	@lua	login
	@text	Prompt the user to login to Facebook.

	@opt	table	extra_permissions	Optional set of required permissions. See Facebook documentation for a full list. Default is nil.
	@opt	boolean allowPubblishing	Optional parameter to allow posting to feed.
	@out 	nil
*/
int MOAIFacebookAndroid::_login ( lua_State *L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	jobjectArray jpermissions = NULL;

	if ( state.IsType ( 1, LUA_TTABLE )) {
        jpermissions = self->StringArrayFromLua ( state, 1 );
	}

	if ( jpermissions == NULL ) {
		jpermissions = self->Env ()->NewObjectArray ( 0, self->Env ()->FindClass( "java/lang/String" ), 0 );
	}

	bool allowPubblishing = lua_toboolean ( state, 2 );

	self->CallStaticVoidMethod ( self->mJava_Login, jpermissions, allowPubblishing );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	logout
	@text	Log the user out of Facebook.

	@out 	nil
*/
int MOAIFacebookAndroid::_logout ( lua_State *L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_Logout );

	return 0;
}

//----------------------------------------------------------------//
/**	@lua	postToFeed
	@text	Post a message to the logged in users' news feed.

	@in		string	url				The URL that the post links to. See Facebook documentation.
	@in		string	img				The URL of an image to include in the post. See Facebook documentation.
	@in		string	caption			The caption of the link. See Facebook documentation.
	@in		string	description		The description of the link. See Facebook documentation.
	@out 	nil
*/
int MOAIFacebookAndroid::_postToFeed ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIFacebookAndroid, "" )

	jstring jurl			= self->GetJString ( lua_tostring ( state, 1 ));
	jstring jimg			= self->GetJString ( lua_tostring ( state, 2 ));
	jstring jcaption		= self->GetJString ( lua_tostring ( state, 3 ));
	jstring jdescription	= self->GetJString ( lua_tostring ( state, 4 ));

	self->CallStaticVoidMethod ( self->mJava_PostToFeed, jurl, jimg, jcaption, jdescription );

	return 0;
}

//================================================================//
// MOAIFacebookAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIFacebookAndroid::MOAIFacebookAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiFacebook" );

	this->mJava_GetToken			= this->GetStaticMethod ( "getToken", "()Ljava/lang/String;" );
	this->mJava_GetUserID			= this->GetStaticMethod ( "getUserID", "()Ljava/lang/String;" );
	//this->mJava_GraphRequest		= this->GetStaticMethod ( "graphRequest", "(Ljava/lang/String;Landroid/os/Bundle;)V" );
	this->mJava_InviteFriends		= this->GetStaticMethod ( "inviteFriends", "(Ljava/lang/String;Ljava/lang/String;)V" );
	this->mJava_IsUserLoggedIn		= this->GetStaticMethod ( "isUserLoggedIn", "()Z" );
	this->mJava_Login				= this->GetStaticMethod ( "login", "([Ljava/lang/String;Z)V" );
	this->mJava_Logout				= this->GetStaticMethod ( "logout", "()V" );
	this->mJava_PostToFeed			= this->GetStaticMethod ( "postToFeed", "(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V" );
}

//----------------------------------------------------------------//
MOAIFacebookAndroid::~MOAIFacebookAndroid () {
}

//----------------------------------------------------------------//
void MOAIFacebookAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	state.SetField ( -1, "FACEBOOK_LOGIN_SUCCESS",	( u32 ) FACEBOOK_LOGIN_SUCCESS );
	state.SetField ( -1, "FACEBOOK_LOGIN_CANCEL",	( u32 ) FACEBOOK_LOGIN_CANCEL );
	state.SetField ( -1, "FACEBOOK_LOGIN_ERROR", 	( u32 ) FACEBOOK_LOGIN_ERROR );
	state.SetField ( -1, "FACEBOOK_DIALOG_SUCCESS", ( u32 ) FACEBOOK_DIALOG_SUCCESS );
	state.SetField ( -1, "FACEBOOK_DIALOG_CANCEL",	( u32 ) FACEBOOK_DIALOG_CANCEL );
	state.SetField ( -1, "FACEBOOK_DIALOG_ERROR",	( u32 ) FACEBOOK_DIALOG_ERROR );

	luaL_Reg regTable [] = {
		{ "getListener",			&MOAIGlobalEventSource::_getListener < MOAIFacebookAndroid > },
		{ "getToken",				_getToken },
		{ "getUserID",				_getUserID },
		{ "graphRequest",			_graphRequest },
		{ "inviteFriends",			_inviteFriends },
		{ "isUserLoggedIn",			_isUserLoggedIn },
		{ "login",					_login },
		{ "logout",					_logout },
		{ "postToFeed",				_postToFeed },
		{ "setListener",			&MOAIGlobalEventSource::_setListener < MOAIFacebookAndroid > },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// Facebook JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiFacebook_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	MOAIFacebookAndroid::Get ().InvokeListener (( u32 )eventID );
}
