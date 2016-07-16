//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.RelativeLayout.LayoutParams;

import com.google.android.gms.ads.AdListener;
import com.google.android.gms.ads.AdRequest;
import com.google.android.gms.ads.AdSize;
import com.google.android.gms.ads.AdView;
import com.google.android.gms.ads.InterstitialAd;

//================================================================//
// MoaiAdMob
//================================================================//
public class MoaiAdMob {

	private static Activity 				sActivity		= null;
	private static AdView					sAdView			= null;
	private static LayoutParams 			sAdViewParams 	= null;
	private static RelativeLayoutIMETrap	sContainer 		= null;
	private static boolean					sHasCachedBanner = false;
	private static InterstitialAd			sInterstitialAd = null;

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiAdMob: onCreate" );
		sActivity = activity;
	}

	//================================================================//
	// ChartBoost JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheBanner () {

		AdRequest adRequest = new AdRequest.Builder ()
				  .addTestDevice ( AdRequest.DEVICE_ID_EMULATOR )
				  .build ();

		sAdView.loadAd ( adRequest );
	}

	//----------------------------------------------------------------//
	public static void cacheInterstitial () {

		AdRequest adRequest = new AdRequest.Builder ()
                  .addTestDevice ( AdRequest.DEVICE_ID_EMULATOR )
                  .build ();

		sInterstitialAd.loadAd ( adRequest );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedBanner () {

		return sHasCachedBanner;
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return sInterstitialAd.isLoaded ();
	}

	//----------------------------------------------------------------//
	public static void hideBanner () {

		if ( sAdView != null ) {

			sAdView.setVisibility ( View.INVISIBLE );
			sAdView.requestLayout ();
		}
	}

	//----------------------------------------------------------------//
	public static void init ( String unitId ) {

		sInterstitialAd = new InterstitialAd ( sActivity );

		sInterstitialAd.setAdUnitId ( unitId );
		sInterstitialAd.setAdListener( new AdListener () {
            @Override
            public void onAdClosed() {}
        } );
	}

	//----------------------------------------------------------------//
	public static void initBannerWithParams ( String unitId, int width, int height, int margin, boolean atBottom ) {

		sContainer = MoaiKeyboard.getContainer ();

		if ( width < 1 ) width = LayoutParams.MATCH_PARENT;
		if ( height < 1 ) height = LayoutParams.WRAP_CONTENT;

		sAdViewParams = new LayoutParams ( width, height );

		if ( atBottom ) {

			sAdViewParams.addRule ( RelativeLayout.ALIGN_PARENT_BOTTOM );
			margin = 0 - margin;
		}
		sAdViewParams.addRule ( RelativeLayout.CENTER_HORIZONTAL );

		if ( sAdView != null ) {

			sContainer.removeView ( sAdView );
			sAdView.destroy();
			sAdView = null;
		}

		// Banner ad
		sAdView = new AdView ( sActivity );
		sAdView.setAdUnitId ( unitId );
		sAdView.setAdSize ( AdSize.SMART_BANNER );

		sAdView.setAdListener ( new AdListener () {

			//----------------------------------------------------------------//
	        @Override
	        public void onAdLoaded () {

	            sHasCachedBanner = true;
	        }

			//----------------------------------------------------------------//
	        @Override
	        public void onAdFailedToLoad ( int errorCode ) {

				sHasCachedBanner = false;
			}
		} );

		sContainer.addView ( sAdView, sAdViewParams );

		sAdView.setTranslationY ( margin );
		sAdView.setVisibility ( View.INVISIBLE );
		sAdView.requestLayout ();
	}

	//----------------------------------------------------------------//
	public static void showBanner () {

		if ( sHasCachedBanner ) {

			sHasCachedBanner = false;

			sAdView.setVisibility ( View.VISIBLE );
			sAdView.requestLayout ();
		}
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( sInterstitialAd.isLoaded () ) {
            sInterstitialAd.show ();
        }
	}
}
