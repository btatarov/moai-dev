package com.ziplinegames.moai;
import com.ziplinegames.moai.*;

import android.app.Activity;
import android.content.IntentSender;

import com.google.android.gms.common.ConnectionResult;
import com.google.android.gms.common.GooglePlayServicesUtil;
import com.google.android.gms.common.api.GoogleApiClient;
import com.google.android.gms.games.GamesActivityResultCodes;

public class MoaiPlayServicesUtils {

    //----------------------------------------------------------------//
    public static int getStringResource ( Activity activity, String name ) {
		return activity.getResources ().getIdentifier ( name, "string", activity.getPackageName () );
	}

    //----------------------------------------------------------------//
    public static boolean resolveConnectionFailure ( Activity activity,
                                                   GoogleApiClient client, ConnectionResult result, int requestCode,
                                                   String fallbackErrorMessage ) {

        if ( result.hasResolution () ) {

            try {

                result.startResolutionForResult ( activity, requestCode );
                return true;

            } catch ( IntentSender.SendIntentException e ) {

                client.connect ();
                return false;
            }

        } else {

            int errorCode = result.getErrorCode ();
            String errorString = GooglePlayServicesUtil.getErrorString ( errorCode );
            String neutralButton = activity.getString ( getStringResource ( activity, "ok" ) );

            if ( errorString == null ) {
                errorString = fallbackErrorMessage;
            }

            MoaiLog.i ( "MoaiPlayServices error: " + errorString );

            return false;
        }
    }

    //----------------------------------------------------------------//
    public static void showActivityResultError ( Activity activity, int requestCode, int actResp, int errorDescription ) {

        if ( activity == null ) {
            MoaiLog.i ( "MoaiPlayServices utils: No Activity. Can't show failure dialog!" );
            return;
        }

        String message = null;
        String neutralButton = activity.getString ( getStringResource ( activity, "ok" ) );

        switch ( actResp ) {
            case GamesActivityResultCodes.RESULT_APP_MISCONFIGURED :
                message = activity.getString ( getStringResource ( activity, "app_misconfigured" ) );
                break;

            case GamesActivityResultCodes.RESULT_SIGN_IN_FAILED :
                message = activity.getString ( getStringResource ( activity, "sign_in_failed" ) );
                break;

            case GamesActivityResultCodes.RESULT_LICENSE_FAILED :
                message = activity.getString ( getStringResource ( activity, "license_failed" ) );
                break;

            default:
                final int errorCode = GooglePlayServicesUtil.isGooglePlayServicesAvailable ( activity );
                message = GooglePlayServicesUtil.getErrorString ( errorCode );

                if ( message == null ) {

                    MoaiLog.i ( "MoaiPlayServices utils: No standard error dialog available. Making fallback dialog.");
                    message = activity.getString ( errorDescription );
                }
        }

        MoaiLog.i ( "MoaiPlayServices result: " + message );
    }

}
