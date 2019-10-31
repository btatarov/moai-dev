//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;
import android.os.Bundle;

import com.adcolony.sdk.*;

//================================================================//
// MoaiAdColony
//================================================================//

public class MoaiAdColony {

	public enum ListenerEvent {
		REWARDED_VIDEO_COMPLETED,
    }

	private static Activity sActivity = null;

	private static AdColonyInterstitial sInterstitial;
	private static String sInterstitialZoneId;

	private static AdColonyAdOptions sAdOptions = new AdColonyAdOptions ()
                .enableConfirmationDialog ( false )
                .enableResultsDialog ( false );

	private static AdColonyInterstitialListener sListener = new AdColonyInterstitialListener () {

		@Override
        public void onRequestFilled ( AdColonyInterstitial ad ) {

			sInterstitial = ad;
		}

        @Override
        public void onRequestNotFilled ( AdColonyZone zone ) {}

        @Override
        public void onOpened ( AdColonyInterstitial ad ) {}

        @Override
        public void onExpiring( AdColonyInterstitial ad ) {

			AdColony.requestInterstitial ( sInterstitialZoneId, this, sAdOptions );
		}
	};

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiAdColony: onCreate" );

		sActivity = activity;
	}

	//----------------------------------------------------------------//
	public static void onPause ( ) {

		MoaiLog.i ( "MoaiAdColony: onPause" );
	}

	//----------------------------------------------------------------//
	public static void onResume ( ) {

		MoaiLog.i ( "MoaiAdColony: onResume" );
	}

	//================================================================//
	// AdColony JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo ( String zoneId ) {

		sInterstitialZoneId = zoneId;
		AdColony.requestInterstitial ( sInterstitialZoneId, sListener, sAdOptions );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return ( ! ( sInterstitial == null || sInterstitial.isExpired () ) );
	}

	//----------------------------------------------------------------//
	public static void init ( String appId, boolean amazon_store, String [] zoneIds ) {

		AdColonyAppOptions app_options = new AdColonyAppOptions ();
		app_options.setKeepScreenOn ( true );

		if ( amazon_store )
			app_options.setOriginStore ( "amazon" );

		AdColony.configure ( sActivity, app_options, appId, zoneIds );

		AdColony.setRewardListener ( new AdColonyRewardListener () {

			@Override
    		public void onReward ( AdColonyReward reward ) {

				AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_COMPLETED.ordinal () );
    		}
		} );
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( ! ( sInterstitial == null || sInterstitial.isExpired () ) ) {

			sInterstitial.show ();
		}
	}
}
