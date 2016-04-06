//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import com.heyzap.sdk.ads.HeyzapAds;
import com.heyzap.sdk.ads.HeyzapAds.OnIncentiveResultListener;
import com.heyzap.sdk.ads.IncentivizedAd;
import com.heyzap.sdk.ads.InterstitialAd;

class MoaiHeyZap {

	public enum ListenerEvent {
		REWARDEDVIDEOAD_COMPLETED,
    }

	private static Activity sActivity = null;

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onBackPressed ( Activity activity ) {

        MoaiLog.i ( "MoaiHeyZap: onBackPressed" );
    }

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiHeyZap: onCreate" );
		sActivity = activity;
	}

	//----------------------------------------------------------------//
	public static void onDestroy ( Activity activity ) {

		MoaiLog.i ( "MoaiHeyZap: onDestroy" );
	}

	//----------------------------------------------------------------//
	public static void onPause ( Activity activity ) {

		MoaiLog.i ( "MoaiHeyZap: onPause" );
	}

	//----------------------------------------------------------------//
	public static void onResume ( Activity activity ) {

		MoaiLog.i ( "MoaiHeyZap: onResume" );
	}

	//----------------------------------------------------------------//
	public static void onStart ( Activity activity ) {

		MoaiLog.i ( "MoaiHeyZap: onStart" );
	}

	//----------------------------------------------------------------//
	public static void onStop ( Activity activity ) {

		MoaiLog.i ( "MoaiHeyZap: onStop" );
	}

	//================================================================//
	// HeyZap JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheInterstitial () {

		// Interstitial ads are automatically fetched from HeyZap server
	}

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo () {

		IncentivizedAd.fetch ();
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return InterstitialAd.isAvailable ();
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return IncentivizedAd.isAvailable ();
	}

	//----------------------------------------------------------------//
	public static void init ( String publisherID ) {

		HeyzapAds.start ( publisherID, sActivity );

		IncentivizedAd.setOnIncentiveResultListener(new OnIncentiveResultListener() {
		    @Override
		    public void onComplete(String tag) {
		        AKUInvokeListener ( ListenerEvent.REWARDEDVIDEOAD_COMPLETED.ordinal () );
		    }

		    @Override
		    public void onIncomplete(String tag) {}
		});
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( InterstitialAd.isAvailable () ) {

			InterstitialAd.display ( sActivity );
		}
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( IncentivizedAd.isAvailable () ) {

    		IncentivizedAd.display ( sActivity );
		}
	}
}
