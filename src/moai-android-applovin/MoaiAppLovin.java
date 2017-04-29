//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import com.applovin.adview.AppLovinIncentivizedInterstitial;
import com.applovin.adview.AppLovinInterstitialAd;
import com.applovin.sdk.AppLovinAd;
import com.applovin.sdk.AppLovinAdVideoPlaybackListener;
import com.applovin.sdk.AppLovinSdk;

class MoaiAppLovin {

	public enum ListenerEvent {
		REWARDED_VIDEO_COMPLETED,
    }

	private static Activity sActivity = null;
	private static AppLovinIncentivizedInterstitial sRewardedVideo;

	private static AppLovinAdVideoPlaybackListener sAppLovinListener = new AppLovinAdVideoPlaybackListener () {

		@Override
		public void videoPlaybackBegan ( AppLovinAd ad ) {}

		@Override
		public void videoPlaybackEnded ( AppLovinAd ad, double percentViewed, boolean fullyWatched ) {

			if ( fullyWatched ) {
				AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_COMPLETED.ordinal () );
			}
    	}
	};

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiAppLovin: onCreate" );
		sActivity = activity;
	}

	//================================================================//
	// RevMob JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo () {

		if ( ! sRewardedVideo.isAdReadyToDisplay () ) {

			sRewardedVideo.preload ( null );
		}
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return AppLovinInterstitialAd.isAdReadyToDisplay ( sActivity );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return sRewardedVideo.isAdReadyToDisplay ();
	}

	//----------------------------------------------------------------//
	public static void init () {

		AppLovinSdk.initializeSdk ( sActivity );
		sRewardedVideo = AppLovinIncentivizedInterstitial.create ( sActivity );
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( AppLovinInterstitialAd.isAdReadyToDisplay ( sActivity ) ) {

			AppLovinInterstitialAd.show ( sActivity );
		}
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( sRewardedVideo.isAdReadyToDisplay () ) {

			sRewardedVideo.show ( sActivity, null, sAppLovinListener, null, null);
		}
	}
}
