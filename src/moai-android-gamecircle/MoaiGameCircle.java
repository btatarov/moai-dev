//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import com.amazon.ags.api.AmazonGamesClient;
import com.amazon.ags.api.AmazonGamesCallback;
import com.amazon.ags.api.AmazonGamesStatus;
import com.amazon.ags.api.AmazonGamesFeature;
import com.amazon.ags.api.AGResponseHandle;
import com.amazon.ags.api.leaderboards.LeaderboardsClient;
import com.amazon.ags.api.leaderboards.SubmitScoreResponse;
import com.amazon.ags.api.achievements.AchievementsClient;
import com.amazon.ags.api.achievements.UpdateProgressResponse;

import java.util.EnumSet;

public class MoaiGameCircle {

    public enum ListenerEvent {

		SERVICE_READY,
		SERVICE_NOT_READY,
    }

    private static Activity sActivity           = null;
    private static AchievementsClient sACClient = null;
    private static AmazonGamesClient sAGClient  = null;
    private static LeaderboardsClient sLBClient = null;

    private static EnumSet < AmazonGamesFeature > sGameFeatures = EnumSet.of (
        AmazonGamesFeature.Achievements, AmazonGamesFeature.Leaderboards
	);

    private static AmazonGamesCallback sGamesCallback = new AmazonGamesCallback () {

        //----------------------------------------------------------------//
		@Override
        public void onServiceNotReady ( AmazonGamesStatus status ) {

            sAGClient = null;
            AKUInvokeListener ( ListenerEvent.SERVICE_NOT_READY.ordinal () );
        }

        //----------------------------------------------------------------//
        @Override
        public void onServiceReady ( AmazonGamesClient amazonGamesClient ) {

            sAGClient = amazonGamesClient;
            sLBClient = sAGClient.getLeaderboardsClient ();
            sACClient = sAGClient.getAchievementsClient ();

            AKUInvokeListener ( ListenerEvent.SERVICE_READY.ordinal () );
        }
    };

    // AKU callbacks
	protected static native void	AKUInvokeListener 	( int eventID );

    //----------------------------------------------------------------//
    public static void onCreate ( Activity activity ) {

        MoaiLog.i ( "MoaiGameCircle onCreate" );

        sActivity = activity;
    }

    //----------------------------------------------------------------//
    public static void onPause () {

        if ( sAGClient != null ) {

            MoaiLog.i ( "MoaiGameCircle onPause: Releasing Amazon GameCircle object" );

            sAGClient.release ();
            sAGClient = null;
        }
    }

    //----------------------------------------------------------------//
    public static void onResume () {

        if ( sAGClient == null ) {

            MoaiLog.i ( "MoaiGameCircle onResume: Initializing Amazon GameCircle" );

			AmazonGamesClient.initialize ( sActivity, sGamesCallback, sGameFeatures );
		}
    }

    //================================================================//
	// GameCircle JNI methods
	//================================================================//

    //----------------------------------------------------------------//
    public static void connect () {

        if ( sAGClient == null ) {

            AmazonGamesClient.initialize ( sActivity, sGamesCallback, sGameFeatures );
		}
    }

    //----------------------------------------------------------------//
	public static boolean isConnected () {

		return ( sAGClient != null );
	}

    //----------------------------------------------------------------//
    public static void showDefaultAchievements () {

        if ( sAGClient != null && sACClient != null ) {

            sACClient.showAchievementsOverlay ();
        }
    }

    //----------------------------------------------------------------//
    public static void showLeaderboard ( String leaderboardId ) {

        if ( sAGClient != null && sLBClient != null ) {

            sLBClient.showLeaderboardOverlay ( leaderboardId );
        }
    }

    //----------------------------------------------------------------//
    public static void reportScore ( String leaderboardId, long score ) {

        if ( sAGClient != null && sLBClient != null ) {

			AGResponseHandle < SubmitScoreResponse > handle = sLBClient.submitScore ( leaderboardId, score );
        }
    }

    //----------------------------------------------------------------//
    public static void reportAchievementProgress ( String achievementId, long progress ) {

		if ( sAGClient != null && sACClient != null ) {

            AGResponseHandle < UpdateProgressResponse > handle = sACClient.updateProgress ( achievementId, progress );
        }
    }
}
