//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import com.vungle.publisher.EventListener;
import com.vungle.publisher.VunglePub;

//================================================================//
// MoaiVungle
//================================================================//

public class MoaiVungle {

	public enum ListenerEvent {
		REWARDED_VIDEO_STARTED,
		REWARDED_VIDEO_FINISH,
		REWARDED_VIDEO_COMPLETED,
    }

	private static final VunglePub vunglePub = VunglePub.getInstance();

	private static Activity sActivity = null;

	protected static native void AKUInvokeListener ( int eventID );

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiVungle: onCreate" );

		sActivity = activity;
	}

	//----------------------------------------------------------------//
	public static void onPause ( ) {

		MoaiLog.i ( "MoaiVungle: onPause" );

		vunglePub.onPause ();
	}

	//----------------------------------------------------------------//
	public static void onResume ( ) {

		MoaiLog.i ( "MoaiVungle: onResume" );

		vunglePub.onResume ();
	}

	//================================================================//
	// MoaiVungle JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static void showRewardedVideo () {

		if ( vunglePub.isAdPlayable () ) {

			vunglePub.playAd ();
		}
	}

	//----------------------------------------------------------------//
	public static void init ( String appId ) {

		vunglePub.init ( sActivity, appId );

		vunglePub.setEventListeners ( new EventListener () {

		    @Override
		    public void onVideoView ( boolean isCompletedView, int watchedMillis, int videoDurationMillis ) {

				if ( isCompletedView ) {
					AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_COMPLETED.ordinal () );
				}
		    }

		    @Override
		    public void onAdStart () {

				AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_STARTED.ordinal () );
		    }

		    @Override
		    public void onAdEnd ( boolean wasCallToActionClicked ) {

				AKUInvokeListener ( ListenerEvent.REWARDED_VIDEO_FINISH.ordinal () );
		    }

		    @Override
		    public void onAdPlayableChanged ( boolean isAdPlayable ) {}

		    @Override
		    public void onAdUnavailable ( String reason ) {}
		} );
	}

	//----------------------------------------------------------------//
	public static boolean hasCachedRewardedVideo () {

		return vunglePub.isAdPlayable ();
	}
}
