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
		AD_START,
		AD_END,
		AD_VIEWED,
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
	public static void displayAdvert () {

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
					AKUInvokeListener ( ListenerEvent.AD_VIEWED.ordinal () );
				}
		    }

		    @Override
		    public void onAdStart () {

				AKUInvokeListener ( ListenerEvent.AD_START.ordinal () );
		    }

		    @Override
		    public void onAdEnd ( boolean wasCallToActionClicked ) {

				AKUInvokeListener ( ListenerEvent.AD_END.ordinal () );
		    }

		    @Override
		    public void onAdPlayableChanged ( boolean isAdPlayable ) {}

		    @Override
		    public void onAdUnavailable ( String reason ) {}
		} );
	}

	//----------------------------------------------------------------//
	public static boolean isVideoAvailable () {

		return vunglePub.isAdPlayable ();
	}
}
