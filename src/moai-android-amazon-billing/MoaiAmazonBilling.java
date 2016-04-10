//----------------------------------------------------------------//
// Copyright (c) 2010-2011 Zipline Games, Inc.
// All Rights Reserved.
// http://getmoai.com
//----------------------------------------------------------------//

package com.ziplinegames.moai;

import android.app.Activity;

import java.util.Iterator;
import java.util.List;

import com.amazon.device.iap.model.ProductDataResponse;
import com.amazon.device.iap.model.PurchaseResponse;
import com.amazon.device.iap.model.PurchaseUpdatesResponse;
import com.amazon.device.iap.model.Receipt;
import com.amazon.device.iap.model.RequestId;
import com.amazon.device.iap.model.UserDataResponse;
import com.amazon.device.iap.PurchasingListener;
import com.amazon.device.iap.PurchasingService;

//================================================================//
// MoaiAmazonBilling
//================================================================//
public class MoaiAmazonBilling implements PurchasingListener {

	private static Activity											sActivity = null;
	private static boolean											sBillingAvailable = false;
	private static String 											sUserId = null;

	protected static native void AKUNotifyAmazonBillingSupported			( boolean supported );
	protected static native void AKUNotifyAmazonPurchaseResponseReceived	( int responseCode, String productId );
	protected static native void AKUNotifyAmazonRestoreResponseReceived		( int responseCode, boolean more, String offset );
	protected static native void AKUNotifyAmazonUserIdDetermined			( int responseCode, String userId );

	//----------------------------------------------------------------//
	public static void onCreate ( Activity activity ) {

		MoaiLog.i ( "MoaiAmazonBilling onCreate: Initializing Amazon Billing" );

		sActivity = activity;

		MoaiAmazonBilling purchasingListener = new MoaiAmazonBilling ();
		PurchasingService.registerListener ( sActivity.getApplicationContext (), purchasingListener );
	}

	//----------------------------------------------------------------//
	public static void onStart () {

		MoaiLog.i ( "MoaiAmazonBilling onStart: Registering purchasing listener" );
	}

	//----------------------------------------------------------------//
	public static void onResume () {

		MoaiLog.i ( "MoaiAmazonBilling onResume: Getting user data." );

		PurchasingService.getUserData ();
	}

	//================================================================//
	// Amazon Billing v2 JNI callback methods
	//================================================================//

	//----------------------------------------------------------------//
	public static boolean checkBillingSupported () {

		return sBillingAvailable;
	}

	//----------------------------------------------------------------//
	public static boolean confirmNotification ( String notificationId ) {

		// unused
		return false;
	}

	//----------------------------------------------------------------//
	public static boolean getUserId () {

		return ( PurchasingService.getUserData () != null );
	}

	//----------------------------------------------------------------//
	public static boolean requestPurchase ( String productId, String developerPayload ) {

		return ( PurchasingService.purchase ( productId ) != null );
	}

	//----------------------------------------------------------------//
	public static boolean restoreTransactions ( String offset ) {

		return ( PurchasingService.getPurchaseUpdates ( true ) != null );
	}

	//----------------------------------------------------------------//
	public static void setPublicKey ( String key ) {

		// unused
	}

	//================================================================//
	// PurchasingListener overrides
	//================================================================//
	@Override
	public void onProductDataResponse ( final ProductDataResponse productDataResponse ) {

		// unused
	}

	@Override
	public void onPurchaseResponse ( final PurchaseResponse purchaseResponse ) {

		final String requestId 	= purchaseResponse.getRequestId ().toString ();
        final String userId 	= purchaseResponse.getUserData ().getUserId ();
		final String sku 		= purchaseResponse.getReceipt ().getSku ();

        final PurchaseResponse.RequestStatus requestStatus = purchaseResponse.getRequestStatus ();

        switch ( requestStatus ) {

		case SUCCESSFUL:

            final Receipt receipt = purchaseResponse.getReceipt ();

            MoaiLog.i ( "onPurchaseResponse: receipt json: " + receipt.toJSON () );

		case ALREADY_PURCHASED:
		case INVALID_SKU:
		case FAILED:
        case NOT_SUPPORTED:

            AKUNotifyAmazonPurchaseResponseReceived ( requestStatus.ordinal () , sku );
		}
	}

	@Override
	public void onPurchaseUpdatesResponse ( final PurchaseUpdatesResponse purchaseUpdatesResponse ) {

		final PurchaseUpdatesResponse.RequestStatus requestStatus = purchaseUpdatesResponse.getRequestStatus ();

        switch ( requestStatus ) {

        case SUCCESSFUL:

			final List < Receipt > receiptList = purchaseUpdatesResponse.getReceipts ();
        	final boolean hasMore = purchaseUpdatesResponse.hasMore ();

			Iterator < Receipt > receiptListIterator = receiptList.iterator ();
			while ( receiptListIterator.hasNext () ) {

				Receipt receipt = receiptListIterator.next ();

				if ( receiptListIterator.hasNext () ) {

					AKUNotifyAmazonRestoreResponseReceived ( requestStatus.ordinal () , true, receipt.getSku () );
				} else {

					AKUNotifyAmazonRestoreResponseReceived ( requestStatus.ordinal () , hasMore, receipt.getSku () );
				}
			}

			if ( hasMore ) PurchasingService.getPurchaseUpdates ( false );
            break;

        case FAILED:
        case NOT_SUPPORTED:

			AKUNotifyAmazonRestoreResponseReceived ( requestStatus.ordinal () , false, null );
        }
	}

	@Override
	public void onUserDataResponse ( final UserDataResponse userDataResponse ) {

		final UserDataResponse.RequestStatus requestStatus = userDataResponse.getRequestStatus ();

		switch ( requestStatus ) {

		case SUCCESSFUL:

			final String userId = userDataResponse.getUserData ().getUserId ();

			if ( ! MoaiAmazonBilling.sBillingAvailable ) {

				MoaiAmazonBilling.sBillingAvailable = true;
				AKUNotifyAmazonBillingSupported ( true );
			}

			if ( ! userId.equals ( MoaiAmazonBilling.sUserId ) ) {

				MoaiAmazonBilling.sUserId = userId;
				AKUNotifyAmazonUserIdDetermined ( requestStatus.ordinal () , userId );
			}

			break;

		case FAILED:
        case NOT_SUPPORTED:

			MoaiAmazonBilling.sUserId = null;
			MoaiAmazonBilling.sBillingAvailable = false;
			AKUNotifyAmazonBillingSupported ( false );
			AKUNotifyAmazonUserIdDetermined ( requestStatus.ordinal (), null );
		}
	}
}
