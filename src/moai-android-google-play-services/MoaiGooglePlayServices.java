//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;
import com.ziplinegames.moai.*;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.Games;

//================================================================//
// MoaiGooglePlayServices
//================================================================//
public class MoaiGooglePlayServices implements
		GoogleApiClient.ConnectionCallbacks,
		GoogleApiClient.OnConnectionFailedListener {

	public enum ListenerEvent {

		CONNECTION_COMPLETE,
		CONNECTION_FAILED,
    }

	public static final int 			RC_SIGN_IN = 9001;
	public static final int 			LEADERBOARD_REQUEST_CODE = 7337;
	public static final int				ACHIEVEMENT_REQUEST_CODE = 7557;

	private static Activity 			sActivity = null;
	private static GoogleApiClient		sGoogleApiClient = null;

	// AKU callbacks
	protected static native void		AKUInvokeListener 	( int eventID );

	//================================================================//
	// Callbacks and inner methods
	//================================================================//

	//----------------------------------------------------------------//
	@Override
	public void onConnected ( Bundle connectionHint ) {

		AKUInvokeListener ( ListenerEvent.CONNECTION_COMPLETE.ordinal () );
	}

	//----------------------------------------------------------------//
	@Override
	public void onConnectionFailed ( ConnectionResult connectionResult ) {

		if ( !MoaiPlayServicesUtils.resolveConnectionFailure ( sActivity,
				sGoogleApiClient, connectionResult,
				MoaiGooglePlayServices.RC_SIGN_IN,
				sActivity.getString ( MoaiPlayServicesUtils.getStringResource ( sActivity, "signin_other_error" ) )
		) ) {

			MoaiLog.i ( "MoaiPlayServices callbacks: connection failure." );
			AKUInvokeListener ( ListenerEvent.CONNECTION_FAILED.ordinal () );
		}
	}

	//----------------------------------------------------------------//
	@Override
	public void onConnectionSuspended ( int i ) {

	    sGoogleApiClient.connect ();
	}

	//----------------------------------------------------------------//
	public static void onActivityResult ( int requestCode, int resultCode, Intent intent ) {

    	if  ( requestCode == MoaiGooglePlayServices.RC_SIGN_IN ) {

			if ( resultCode == sActivity.RESULT_OK ) {

            	sGoogleApiClient.connect ();
        	} else {

            	MoaiPlayServicesUtils.showActivityResultError (
					sActivity, requestCode, resultCode,
					MoaiPlayServicesUtils.getStringResource ( sActivity, "signin_failure" )
				);
			}
        }
    }

	//----------------------------------------------------------------//
	public static void buildClient () {

		if ( sGoogleApiClient == null) {

			MoaiGooglePlayServices sConnectionCallbacks = new MoaiGooglePlayServices ();
			MoaiGooglePlayServices sFailedCallback = new MoaiGooglePlayServices ();

			sGoogleApiClient = new GoogleApiClient.Builder ( sActivity )
	            .addConnectionCallbacks ( sConnectionCallbacks )
	            .addOnConnectionFailedListener ( sFailedCallback )
	            .addApi ( Games.API ).addScope ( Games.SCOPE_GAMES )
				.build ();
		}
	}

	//================================================================//
	// Default
	//================================================================//

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiGooglePlayServices onCreate" );

		sActivity = activity;
	}

	//----------------------------------------------------------------//
	public static void onStart () {

		MoaiLog.i ( "MoaiGooglePlayServices onStart" );

		if ( sGoogleApiClient != null ) {
			sGoogleApiClient.connect ();
		}
	}

	//----------------------------------------------------------------//
	public static void onStop () {

		MoaiLog.i ( "MoaiGooglePlayServices onStop" );

		if ( sGoogleApiClient != null ) {
			sGoogleApiClient.disconnect ();
		}
	}

	//================================================================//
	// Google Services JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void connect () {

		if ( sGoogleApiClient == null ) {

			buildClient ();
		}

		sGoogleApiClient.connect ();
	}

	//----------------------------------------------------------------//
	public static boolean isConnected () {

		return ( sGoogleApiClient != null && sGoogleApiClient.isConnected () );
	}

	//----------------------------------------------------------------//
	public static void showAchievements ( ) {

		if ( sGoogleApiClient != null && sGoogleApiClient.isConnected () ) {

			Intent achIntent = Games.Achievements.getAchievementsIntent ( sGoogleApiClient );
			sActivity.startActivityForResult ( achIntent, ACHIEVEMENT_REQUEST_CODE );
		}
	}

	//----------------------------------------------------------------//
	public static void showLeaderboard ( String leaderboardID ) {

		if ( sGoogleApiClient != null && sGoogleApiClient.isConnected () ) {

			Intent lbIntent = Games.Leaderboards.getLeaderboardIntent ( sGoogleApiClient, leaderboardID );
			sActivity.startActivityForResult ( lbIntent, LEADERBOARD_REQUEST_CODE );
		}
	}

	//----------------------------------------------------------------//
	public static void submitScore ( String leaderboardID, long score ) {

		if ( sGoogleApiClient != null && sGoogleApiClient.isConnected () ) {

			Games.Leaderboards.submitScore ( sGoogleApiClient, leaderboardID, score );
		}
	}

	//----------------------------------------------------------------//
	public static void unlockAchievement ( String achID ) {

		if ( sGoogleApiClient != null && sGoogleApiClient.isConnected () ) {

			Games.Achievements.unlock ( sGoogleApiClient, achID );
		}
	}
}
