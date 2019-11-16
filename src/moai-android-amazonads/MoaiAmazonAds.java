//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;
import android.view.View;
import android.widget.RelativeLayout;

import com.amazon.device.ads.Ad;
import com.amazon.device.ads.AdError;
import com.amazon.device.ads.AdLayout;
import com.amazon.device.ads.AdProperties;
import com.amazon.device.ads.AdRegistration;
import com.amazon.device.ads.DefaultAdListener;
import com.amazon.device.ads.InterstitialAd;

//================================================================//
// MoaiAmazonAds
//================================================================//
public class MoaiAmazonAds {

	private static Activity			sActivity				= null;
	private static AdLayout			sAdView					= null;
	private static RelativeLayout.LayoutParams sAdViewParams = null;
	private static RelativeLayoutIMETrap sContainer 		= null;
	private static boolean			sHasCachedBanner		= false;
	private static boolean			sHasCachedInterstitial	= false;
	private static InterstitialAd	sInterstitialAd			= null;

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiAmazonAds: onCreate" );

		sActivity 		= activity;
	}

	//----------------------------------------------------------------//
	public static void onDestroy () {

		MoaiLog.i ( "MoaiAmazonAds: onDestroy" );

		if ( sAdView != null ) {

			sAdView.destroy ();
		}
	}

	//================================================================//
	// AmazonAds JNI methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheBanner () {

		if ( sAdView != null && ! sHasCachedBanner ) {

			sAdView.loadAd ();
		}
	}

	//----------------------------------------------------------------//
	public static void cacheInterstitial () {

		if ( sInterstitialAd != null && ! sHasCachedInterstitial ) {

			sInterstitialAd.loadAd ();
		}
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedBanner () {

		return sHasCachedBanner;
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return sHasCachedInterstitial;
	}

	//----------------------------------------------------------------//
	public static void hideBanner () {

		if ( sAdView != null ) {

			sAdView.setVisibility ( View.GONE );
			sAdView.requestLayout ();
		}
	}

	//----------------------------------------------------------------//
	public static void init ( String appKey ) {

		sContainer = MoaiKeyboard.getContainer ();

		AdRegistration.setAppKey ( appKey );
		// AdRegistration.enableTesting ( true );

		// Interstitial ad
		sInterstitialAd = new InterstitialAd ( sActivity );

		sInterstitialAd.setListener ( new DefaultAdListener () {

			//----------------------------------------------------------------//
	        @Override
	        public void onAdLoaded ( final Ad ad, final AdProperties adProperties ) {

	            sHasCachedInterstitial = true;
	        }

			//----------------------------------------------------------------//
	        @Override
	        public void onAdFailedToLoad ( final Ad view, final AdError error ) {

				sHasCachedInterstitial = false;
			}
		} );
	}

	//----------------------------------------------------------------//
	public static void initBannerWithParams ( int width, int height, int margin, boolean atBottom ) {

		if ( width < 1 ) width = RelativeLayout.LayoutParams.MATCH_PARENT;
		if ( height < 1 ) height = RelativeLayout.LayoutParams.WRAP_CONTENT;

		sAdViewParams = new RelativeLayout.LayoutParams ( width, height );

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
		sAdView = new AdLayout ( sActivity );
		sAdView.setTimeout ( 20000 ); // Fail after 20 seconds

		sContainer.addView ( sAdView, sAdViewParams );

		sAdView.setListener ( new DefaultAdListener () {

			//----------------------------------------------------------------//
	        @Override
	        public void onAdLoaded ( final Ad ad, final AdProperties adProperties ) {

	            sHasCachedBanner = true;
	        }

			//----------------------------------------------------------------//
	        @Override
	        public void onAdFailedToLoad ( final Ad view, final AdError error ) {

				sHasCachedBanner = false;
			}
		} );

		sAdView.setTranslationY ( margin );
		sAdView.setVisibility ( View.GONE );
	}

	//----------------------------------------------------------------//
	public static void showBanner () {

		if ( sAdView != null && sHasCachedBanner ) {

			sHasCachedBanner = false;

			sAdView.setVisibility ( View.VISIBLE );
			sAdView.requestLayout ();
		}
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( sInterstitialAd != null && sHasCachedInterstitial ) {

			sHasCachedInterstitial = false;
			sInterstitialAd.showAd ();
		}
	}
}
