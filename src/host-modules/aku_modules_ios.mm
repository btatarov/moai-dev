// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <Foundation/Foundation.h>
#include <string.h>
#include <zl-common/zl_platform.h>
#include <host-modules/aku_modules_ios.h>

//================================================================//
// implementation
//================================================================//

//----------------------------------------------------------------//
void AKUModulesIosAppFinalize () {

	#if AKU_WITH_IOS
		AKUIosAppFinalize ();
	#endif

	#if AKU_WITH_IOS_ADCOLONY
		AKUIosAdColonyAppFinalize ();
	#endif

	#if AKU_WITH_IOS_ADMOB
		AKUIosAdMobAppFinalize ();
	#endif

	#if AKU_WITH_IOS_APPLOVIN
		AKUIosAppLovinAppFinalize ();
	#endif

	#if AKU_WITH_IOS_BILLING
		AKUIosBillingAppFinalize ();
	#endif

	#if AKU_WITH_IOS_CHARTBOOST
		AKUIosChartBoostAppFinalize ();
	#endif

	#if AKU_WITH_IOS_CRITTERCISM
		AKUIosCrittercismAppFinalize ();
	#endif

	#if AKU_WITH_IOS_FACEBOOK
		AKUIosFacebookAppFinalize ();
	#endif

	#if AKU_WITH_IOS_FLURRY
		AKUIosFlurryAppFinalize ();
	#endif

	#if AKU_WITH_IOS_GAMECENTER
		AKUIosGameCenterAppFinalize ();
	#endif

	#if AKU_WITH_IOS_KONTAGENT
		AKUIosKontagentAppFinalize ();
	#endif

	#if AKU_WITH_IOS_MIXPANEL
		AKUIosMixpanelAppFinalize ();
	#endif

	#if AKU_WITH_IOS_MOBILE_APP_TRACKER
		AKUIosMobileAppTrackerAppFinalize ();
	#endif

	#if AKU_WITH_IOS_MOTION
	  AKUIosMotionAppFinalize ();
	#endif

	#if AKU_WITH_IOS_MOVIE
		AKUIosMovieAppFinalize ();
	#endif

	#if AKU_WITH_IOS_REVMOB
		AKUIosRevMobAppFinalize ();
	#endif

	#if AKU_WITH_IOS_STARTAPP
		AKUIosStartAppAppFinalize ();
	#endif

	#if AKU_WITH_IOS_TAPJOY
		AKUIosTapjoyAppFinalize ();
	#endif

	#if AKU_WITH_IOS_URBAN_AIRSHIP
		AKUIosUrbanAirshipAppFinalize ();
	#endif

	#if AKU_WITH_IOS_VUNGLE
		AKUIosVungleAppFinalize ();
	#endif
}

//----------------------------------------------------------------//
void AKUModulesIosAppInitialize () {

	#if AKU_WITH_IOS
		AKUIosAppInitialize ();
	#endif

	#if AKU_WITH_IOS_ADCOLONY
		AKUIosAdColonyAppInitialize ();
	#endif

	#if AKU_WITH_IOS_ADMOB
		AKUIosAdMobAppInitialize ();
	#endif

	#if AKU_WITH_IOS_APPLOVIN
		AKUIosAppLovinAppInitialize ();
	#endif

	#if AKU_WITH_IOS_BILLING
		AKUIosBillingAppInitialize ();
	#endif

	#if AKU_WITH_IOS_CHARTBOOST
		AKUIosChartBoostAppInitialize ();
	#endif

	#if AKU_WITH_IOS_CRITTERCISM
		AKUIosCrittercismAppInitialize ();
	#endif

	#if AKU_WITH_IOS_FACEBOOK
		AKUIosFacebookAppInitialize ();
	#endif

	#if AKU_WITH_IOS_FLURRY
		AKUIosFlurryAppInitialize ();
	#endif

	#if AKU_WITH_IOS_GAMECENTER
		AKUIosGameCenterAppInitialize ();
	#endif

	#if AKU_WITH_IOS_KONTAGENT
		AKUIosKontagentAppInitialize ();
	#endif

	#if AKU_WITH_IOS_MIXPANEL
		AKUIosMixpanelAppInitialize ();
	#endif

	#if AKU_WITH_IOS_MOBILE_APP_TRACKER
		AKUIosMobileAppTrackerAppInitialize ();
	#endif

	#if AKU_WITH_IOS_MOTION
	  AKUIosMotionAppInitialize ();
	#endif

	#if AKU_WITH_IOS_MOVIE
		AKUIosMovieAppInitialize ();
	#endif

	#if AKU_WITH_IOS_REVMOB
		AKUIosRevMobAppInitialize ();
	#endif

	#if AKU_WITH_IOS_STARTAPP
		AKUIosStartAppAppInitialize ();
	#endif

	#if AKU_WITH_IOS_TAPJOY
		AKUIosTapjoyAppInitialize ();
	#endif

	#if AKU_WITH_IOS_URBAN_AIRSHIP
		AKUIosUrbanAirshipAppInitialize ();
	#endif

	#if AKU_WITH_IOS_VUNGLE
		AKUIosVungleAppInitialize ();
	#endif
}

//----------------------------------------------------------------//
BOOL AKUModulesIosApplicationDidFinishLaunchingWithOptions ( UIApplication* application, NSDictionary* launchOptions ) {

    BOOL status = YES;

#ifdef AKU_WITH_IOS_FACEBOOK
    // status = [ [ FBSDKApplicationDelegate sharedInstance ] application:application
    //                             didFinishLaunchingWithOptions:launchOptions ];
#endif

    return status;
}

//----------------------------------------------------------------//
BOOL AKUModulesIosApplicationOpenURL ( UIApplication* application,  NSURL* url, NSString* sourceApplication, id annotation ) {

#ifdef AKU_WITH_IOS_FACEBOOK
    // return [ [ FBSDKApplicationDelegate sharedInstance ] application:application
    //                                                          openURL:url
    //                                                sourceApplication:sourceApplication
    //                                                       annotation:annotation
    //         ];
#endif

    return NO;
}

//----------------------------------------------------------------//
void AKUModulesIosContextInitialize () {

	#if AKU_WITH_IOS
		AKUIosContextInitialize ();
	#endif

	#if AKU_WITH_IOS_ADCOLONY
		AKUIosAdColonyContextInitialize ();
	#endif

	#if AKU_WITH_IOS_ADMOB
		AKUIosAdMobContextInitialize ();
	#endif

	#if AKU_WITH_IOS_APPLOVIN
		AKUIosAppLovinContextInitialize ();
	#endif

	#if AKU_WITH_IOS_BILLING
		AKUIosBillingContextInitialize ();
	#endif

	#if AKU_WITH_IOS_CHARTBOOST
		AKUIosChartBoostContextInitialize ();
	#endif

	#if AKU_WITH_IOS_CRITTERCISM
		AKUIosCrittercismContextInitialize ();
	#endif

	#if AKU_WITH_IOS_FACEBOOK
		AKUIosFacebookContextInitialize ();
	#endif

	#if AKU_WITH_IOS_FLURRY
		AKUIosFlurryContextInitialize ();
	#endif

	#if AKU_WITH_IOS_GAMECENTER
		AKUIosGameCenterContextInitialize ();
	#endif

	#if AKU_WITH_IOS_KONTAGENT
		AKUIosKontagentContextInitialize ();
	#endif

	#if AKU_WITH_IOS_MIXPANEL
		AKUIosMixpanelContextInitialize ();
	#endif

	#if AKU_WITH_IOS_MOBILE_APP_TRACKER
		AKUIosMobileAppTrackerContextInitialize ();
	#endif

	#if AKU_WITH_IOS_MOTION
	   AKUIosMotionContextInitialize ();
	#endif

	#if AKU_WITH_IOS_MOVIE
		AKUIosMovieContextInitialize ();
	#endif

	#if AKU_WITH_IOS_REVMOB
		AKUIosRevMobContextInitialize ();
	#endif

	#if AKU_WITH_IOS_STARTAPP
		AKUIosStartAppContextInitialize ();
	#endif

	#if AKU_WITH_IOS_TAPJOY
		AKUIosTapjoyContextInitialize ();
	#endif

	#if AKU_WITH_IOS_URBAN_AIRSHIP
		AKUIosUrbanAirshipContextInitialize ();
	#endif

	#if AKU_WITH_IOS_VUNGLE
		AKUIosVungleContextInitialize ();
	#endif
}

//----------------------------------------------------------------//
void AKUModulesIosPause ( bool pause ) {
	UNUSED ( pause );
}


//----------------------------------------------------------------//
void AKUModulesIosUpdate () {
}
