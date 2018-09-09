//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import com.startapp.android.publish.adsCommon.Ad;
import com.startapp.android.publish.adsCommon.StartAppAd;
import com.startapp.android.publish.adsCommon.StartAppAd.AdMode;
import com.startapp.android.publish.adsCommon.StartAppSDK;
import com.startapp.android.publish.adsCommon.VideoListener;
import com.startapp.android.publish.adsCommon.adListeners.AdEventListener;

class MoaiStartApp {

	public enum ListenerEvent {
		REWARDED_VIDEO_COMPLETED,
    }

	private static StartAppAd rewardedVideoAd = null;
	private static StartAppAd startAppAd = null;

	private static AdEventListener rewardedVideoListener = new AdEventListener () {

	    @Override
	    public void onReceiveAd ( Ad ad ) {
			_hasCachedRewardedVideo = true;
	    }

		@Override
		public void onFailedToReceiveAd ( Ad ad ) {}
	};

	private static AdEventListener interstitialListener = new AdEventListener () {

	    @Override
	    public void onReceiveAd ( Ad ad ) {
			_hasCachedInterstitial = true;
	    }

		@Override
		public void onFailedToReceiveAd ( Ad ad ) {}
	};

	private static boolean _hasCachedInterstitial = false;
	private static boolean _hasCachedRewardedVideo = false;

	private static Activity sActivity = null;

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onBackPressed () {

        MoaiLog.i ( "MoaiStartApp: onBackPressed" );

		if ( startAppAd != null ) {

			startAppAd.onBackPressed ();
		}
    }

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiStartApp: onCreate" );
		sActivity = activity;
	}

	//================================================================//
	// StartApp JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheInterstitial () {

		startAppAd.loadAd ( interstitialListener );
	}

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo () {

		rewardedVideoAd.loadAd ( AdMode.REWARDED_VIDEO, rewardedVideoListener );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return _hasCachedInterstitial;
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return _hasCachedRewardedVideo;
	}

	//----------------------------------------------------------------//
	public static void init ( String appId ) {

		StartAppSDK.init ( sActivity, appId, true );

		rewardedVideoAd = new StartAppAd ( sActivity );
		rewardedVideoAd.setVideoListener ( new VideoListener () {

		     @Override
		     public void onVideoCompleted () {

				 AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_COMPLETED.ordinal () );
		     }

		} );

		startAppAd = new StartAppAd ( sActivity );
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( _hasCachedInterstitial ) {

			_hasCachedInterstitial = false;
			startAppAd.showAd ();
		}
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( _hasCachedRewardedVideo ) {

			_hasCachedRewardedVideo = false;
			rewardedVideoAd.showAd ();
		}
	}
}
