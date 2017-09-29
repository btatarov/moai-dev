//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import rm.com.android.sdk.Rm;
import rm.com.android.sdk.RmListener;

class MoaiRevMob {

	public enum ListenerEvent {
		REWARDED_VIDEO_COMPLETED,
    }

	private static Activity sActivity = null;

	private static RmListener.ShowRewardedVideo revmobListener = new RmListener.ShowRewardedVideo () {

		@Override
		public void onRmRewardedVideoCompleted () {

			AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_COMPLETED.ordinal () );
		}

		@Override
		public void onRmAdDisplayed () {}

		@Override
		public void onRmAdFailed ( String message ) {}

		@Override
		public void onRmAdDismissed() {}

		@Override
		public void onRmAdClicked() {}
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
	public static void cacheInterstitial ( String placementId ) {

		Rm.cacheInterstitial ( placementId );
	}

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo ( String placementId ) {

		Rm.cacheRewardedVideo ( placementId );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedInterstitial ( String placementId ) {

		return Rm.isInterstitialLoaded ( placementId );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo ( String placementId ) {

		return Rm.isRewardedVideoLoaded ( placementId );
	}

	//----------------------------------------------------------------//
	public static void init ( String appId ) {

		Rm.init ( sActivity, appId );
	}

	//----------------------------------------------------------------//
	public static void showInterstitial ( String placementId ) {

		if ( Rm.isInterstitialLoaded ( placementId ) ) {

			Rm.showInterstitial ( sActivity, placementId );
		}
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo ( String placementId ) {

		if ( Rm.isRewardedVideoLoaded ( placementId ) ) {

			Rm.showRewardedVideo ( sActivity, placementId, revmobListener );
		}
	}
}
