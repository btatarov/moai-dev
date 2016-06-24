//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import java.io.IOException;
import java.net.MalformedURLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import android.app.Activity;
import android.content.Intent;
import android.content.SharedPreferences;
import android.net.Uri;
import android.os.Bundle;
import android.preference.PreferenceManager;

import com.facebook.AccessToken;
import com.facebook.CallbackManager;
import com.facebook.FacebookCallback;
import com.facebook.FacebookException;
import com.facebook.FacebookSdk;
import com.facebook.GraphResponse;
import com.facebook.GraphRequest;
import com.facebook.HttpMethod;
import com.facebook.login.LoginManager;
import com.facebook.login.LoginResult;
import com.facebook.share.Sharer;
import com.facebook.share.widget.AppInviteDialog;
import com.facebook.share.widget.ShareDialog;
import com.facebook.share.model.AppInviteContent;
import com.facebook.share.model.ShareLinkContent;

import org.json.*;

//================================================================//
// MoaiFacebook
//================================================================//
public class MoaiFacebook {

	public enum ListenerEvent {

		FACEBOOK_LOGIN_SUCCESS,
		FACEBOOK_LOGIN_CANCEL,
		FACEBOOK_LOGIN_ERROR,
		FACEBOOK_DIALOG_SUCCESS,
        FACEBOOK_DIALOG_CANCEL,
        FACEBOOK_DIALOG_ERROR,
    }

	private static Activity			sActivity			= null;
	private static AppInviteDialog	sAppInviteDialog	= null;
    private static CallbackManager	sCallbackManager	= null;
	private static AccessToken		sLoginAccessToken	= null;
    private static String			sUserEmail			= null;
    private static String			sUserID				= null;
    private static String			sUserName			= null;
	private static ShareDialog 		sShareDialog		= null;

	protected static native void	AKUInvokeListener 	( int eventID );

	// Since both Sharer.Result and AppInviteDialog.Result extend Object
	private static FacebookCallback sDialogCallback = new FacebookCallback () {

		@Override
        public void onSuccess ( Object dialogResult ) {

			AKUInvokeListener ( ListenerEvent.FACEBOOK_DIALOG_SUCCESS.ordinal () );
		}

		@Override
		public void onCancel () {

			AKUInvokeListener ( ListenerEvent.FACEBOOK_DIALOG_CANCEL.ordinal () );
		}

		@Override
		public void onError ( FacebookException e ) {

			MoaiLog.i ( "MoaiFacebook postToFeed: ERROR" );
			e.printStackTrace ();

			AKUInvokeListener ( ListenerEvent.FACEBOOK_DIALOG_ERROR.ordinal () );
		}
	};

    private static FacebookCallback sLoginCallback = new FacebookCallback<LoginResult> () {

        @Override
        public void onSuccess ( LoginResult loginResult ) {

            sLoginAccessToken = loginResult.getAccessToken ();

            GraphRequest.newMeRequest (
                    sLoginAccessToken, new GraphRequest.GraphJSONObjectCallback () {

                        @Override
                        public void onCompleted ( JSONObject json, GraphResponse response ) {

                            if ( response.getError () != null ) {

								AKUInvokeListener ( ListenerEvent.FACEBOOK_LOGIN_ERROR.ordinal () );
                            } else {

                                try {

                                    sUserID         = json.getString ( "id" );
                                    sUserName       = json.getString ( "name" );

                                    AKUInvokeListener ( ListenerEvent.FACEBOOK_LOGIN_SUCCESS.ordinal () );

                                } catch ( JSONException e ) {

                                    e.printStackTrace();
                                }
                            }
                        }

                }
			).executeAsync ();
        }

        @Override
        public void onCancel () {

            sUserEmail      = null;
            sUserID         = null;
            sUserName       = null;

            AKUInvokeListener ( ListenerEvent.FACEBOOK_LOGIN_CANCEL.ordinal () );
        }

        @Override
        public void onError ( FacebookException e ) {

            sUserEmail      = null;
            sUserID         = null;
            sUserName       = null;

			MoaiLog.i ( "MoaiFacebook login: ERROR" );
			e.printStackTrace ();

            AKUInvokeListener ( ListenerEvent.FACEBOOK_LOGIN_ERROR.ordinal () );
        }
    };

	//----------------------------------------------------------------//
	public static void onActivityResult ( int requestCode, int resultCode, Intent data ) {

        sCallbackManager.onActivityResult ( requestCode, resultCode, data );
	}

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiFacebook: onCreate" );

		sActivity = activity;

		FacebookSdk.sdkInitialize ( activity );
		sCallbackManager = CallbackManager.Factory.create ();
        LoginManager.getInstance ().registerCallback ( sCallbackManager, sLoginCallback );

		sAppInviteDialog = new AppInviteDialog ( activity );
		sAppInviteDialog.registerCallback ( sCallbackManager, sDialogCallback );

		sShareDialog = new ShareDialog ( activity );
		sShareDialog.registerCallback ( sCallbackManager, sDialogCallback );
	}

	//----------------------------------------------------------------//
	public static void onResume ( ) {

		MoaiLog.i ( "MoaiFacebook: onResume" );
	}

	//================================================================//
	// Facebook JNI callback methods
	//================================================================//

    //----------------------------------------------------------------//
    public static String getToken () {

        return sLoginAccessToken.getToken ();
    }

    //----------------------------------------------------------------//
    public static String getUserID () {

        return sUserID;
    }

	//----------------------------------------------------------------//
    public static void inviteFriends ( String url, String img ) {

        if ( AppInviteDialog.canShow () ) {

            AppInviteContent content = new AppInviteContent.Builder ()
                    .setApplinkUrl ( url )
                    .setPreviewImageUrl ( img )
                    .build ();

            sAppInviteDialog.show ( sActivity, content );
        }
    }

	//----------------------------------------------------------------//
	public static boolean isUserLoggedIn () {

		MoaiLog.i ( "user_id: buffer" );
		MoaiLog.i ( "user_id: " + getUserID() );
		return getUserID() != null;
	}

	//----------------------------------------------------------------//
	public static void login ( String [] extra_permissions, boolean allowPubblishing ) {

        ArrayList<String> permissions = new ArrayList<String> ();

        permissions.add ( "public_profile" );
        permissions.add ( "email" );

		for ( int i = 0; i < extra_permissions.length; i++ ) {

			permissions.add ( extra_permissions[ i ] );
		}

		if ( allowPubblishing ) {

			LoginManager.getInstance ().logInWithPublishPermissions ( sActivity, permissions );
		} else {

			LoginManager.getInstance ().logInWithReadPermissions ( sActivity, permissions );
		}
	}

	//----------------------------------------------------------------//
	public static void logout () {

		sUserEmail      = null;
		sUserID         = null;
		sUserName       = null;

        LoginManager.getInstance ().logOut ();
	}

	//----------------------------------------------------------------//
	public static void postToFeed ( String url, String img, String caption, String description ) {

		if ( ShareDialog.canShow ( ShareLinkContent.class ) ) {

		    ShareLinkContent linkContent = new ShareLinkContent.Builder ()
					.setContentUrl ( Uri.parse ( url ) )
					.setImageUrl ( Uri.parse ( img ) )
		            .setContentTitle ( caption )
		            .setContentDescription ( description )
		            .build ();

		    sShareDialog.show ( linkContent );
		}
	}
}
