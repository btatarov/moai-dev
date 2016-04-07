//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import com.revmob.RevMob;
import com.revmob.RevMobAdsListener;
import com.revmob.ads.interstitial.RevMobFullscreen;

class MoaiRevMob {

	public enum ListenerEvent {
		REWARDEDVIDEOAD_COMPLETED,
    }

	private static Activity sActivity = null;
	private static RevMob revmob;
	private static RevMobFullscreen fullscreen;
	private static RevMobFullscreen rewardedVideo;

	private static RevMobAdsListener revmobListener = new RevMobAdsListener () {

		@Override
        public void onRevMobAdReceived () {
            MoaiLog.i("MoaiRevMob: fullscreen ad has been cached.");
        }

		@Override
		public void onRevMobRewardedVideoCompleted () {
			AKUInvokeListener ( ListenerEvent.REWARDEDVIDEOAD_COMPLETED.ordinal () );
		}

		@Override
		public void onRevMobRewardedVideoLoaded () {
			MoaiLog.i("MoaiRevMob: rewarded video has been cached.");
		}
	};

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiRevMob: onCreate" );
		sActivity = activity;
	}

	//================================================================//
	// RevMob JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheInterstitial () {

		fullscreen = revmob.createFullscreen ( sActivity, revmobListener );
	}

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo () {

		rewardedVideo = revmob.createRewardedVideo ( sActivity, revmobListener );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial () {

		return revmob.isAdLoaded ();
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return revmob.isRewardedVideoLoaded ();
	}

	//----------------------------------------------------------------//
	public static void init () {

		revmob = RevMob.startWithListener ( sActivity, revmobListener );
	}

	//----------------------------------------------------------------//
	public static void showInterstitial () {

		if ( revmob.isAdLoaded () ) {

			fullscreen.show ();
		}
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( revmob.isRewardedVideoLoaded () ) {

			rewardedVideo.showRewardedVideo ();
		}
	}
}
