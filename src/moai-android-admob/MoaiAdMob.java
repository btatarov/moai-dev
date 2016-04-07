//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;
import android.view.View;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.InterstitialAd;

//================================================================//
// MoaiAdMob
//================================================================//
public class MoaiAdMob {

	private static Activity sActivity = null;
	private static InterstitialAd sInterstitialAd = null;

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiAdMob: onCreate" );
		sActivity = activity;
	}

	//================================================================//
	// ChartBoost JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheInterstitial () {

		AdRequest adRequest = new AdRequest.Builder ()
                  .addTestDevice ( AdRequest.DEVICE_ID_EMULATOR )
                  .build ();

		sInterstitialAd.loadAd ( adRequest );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return sInterstitialAd.isLoaded ();
	}

	//----------------------------------------------------------------//
	public static void init ( String unitId ) {

		sInterstitialAd = new InterstitialAd( sActivity );

		sInterstitialAd.setAdUnitId ( unitId );
		sInterstitialAd.setAdListener( new AdListener () {
            @Override
            public void onAdClosed() {}
        } );
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( sInterstitialAd.isLoaded () ) {
            sInterstitialAd.show ();
        }
	}
}
