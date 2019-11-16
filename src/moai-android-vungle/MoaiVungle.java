//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;
import com.vungle.warren.InitCallback;
import com.vungle.warren.PlayAdCallback;
import com.vungle.warren.Vungle;

//================================================================//
// MoaiVungle
//================================================================//

public class MoaiVungle {

	public enum ListenerEvent {
		REWARDED_VIDEO_STARTED,
		REWARDED_VIDEO_FINISH,
		REWARDED_VIDEO_COMPLETED,
    }

	private static String sPlacementId;
	private static Activity sActivity = null;

	private static PlayAdCallback vunglePlayAdCallback = new PlayAdCallback () {

      @Override
      public void onAdStart ( final String placementReferenceID ) {

					AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_STARTED.ordinal () );
      }

      @Override
      public void onAdEnd ( final String placementReferenceID, final boolean completed, final boolean isCTAClicked ) {

					AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_COMPLETED.ordinal () );
      }

      @Override
      public void onError ( final String placementReferenceID, Throwable throwable ) {}
  };

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiVungle: onCreate" );

		sActivity = activity;
	}

	//----------------------------------------------------------------//
	public static void onPause ( ) {

		MoaiLog.i ( "MoaiVungle: onPause" );
	}

	//----------------------------------------------------------------//
	public static void onResume ( ) {

		MoaiLog.i ( "MoaiVungle: onResume" );
	}

	//================================================================//
	// MoaiVungle JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void cacheRewardedVideo () {

		if ( Vungle.isInitialized () ) {

			Vungle.loadAd ( sPlacementId, null );
		}
	}

	//----------------------------------------------------------------//
	public static void init ( String appId, String placementId ) {

		sPlacementId = placementId;

		Vungle.init ( appId, sActivity.getApplicationContext (), new InitCallback () {

			@Override
      		public void onSuccess () {}

			@Override
      		public void onError ( Throwable throwable ) {

				MoaiLog.i ( "MoaiVungle: onError - " + throwable.getLocalizedMessage() );
			}

			@Override
      		public void onAutoCacheAdAvailable ( final String placementReferenceID ) {}
		} );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return ( Vungle.isInitialized () && Vungle.canPlayAd ( sPlacementId ) );
	}

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( Vungle.isInitialized () && Vungle.canPlayAd ( sPlacementId ) ) {

			Vungle.playAd ( sPlacementId, null, vunglePlayAdCallback );
		}
	}
}
