// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <zl-common/zl_platform.h>
#include <host-modules/aku_modules_android.h>

//================================================================//
// implementation
//================================================================//

//----------------------------------------------------------------//
void AKUModulesAndroidAppFinalize () {

	#if AKU_WITH_ANDROID_ADCOLONY
		AKUAndroidAdColonyAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_ADMOB
		AKUAndroidAdMobAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_AMAZON_ADS
		AKUAndroidAmazonAdsAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_CHARTBOOST
		AKUAndroidChartBoostAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_CRITTERCISM
		AKUAndroidCrittercismAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_FACEBOOK
		AKUAndroidFacebookAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_FLURRY
	  AKUAndroidFlurryAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_GAMECIRCLE
	  AKUAndroidGameCircleAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_GOOGLE_PLAY_SERVICES
		AKUAndroidGooglePlayServicesAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_HEYZAP
		AKUAndroidHeyZapAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_OBB_DOWNLOADER
		AKUAndroidObbDownloaderAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_REVMOB
		AKUAndroidRevMobAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_STARTAPP
		AKUAndroidStartAppAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_TAPJOY
		AKUAndroidTapjoyAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_TWITTER
		AKUAndroidTwitterAppFinalize ();
	#endif

	#if AKU_WITH_ANDROID_VUNGLE
		AKUAndroidVungleAppFinalize ();
	#endif

}

//----------------------------------------------------------------//
void AKUModulesAndroidAppInitialize () {

	#if AKU_WITH_ANDROID_ADCOLONY
		AKUAndroidAdColonyAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_ADMOB
		AKUAndroidAdMobAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_AMAZON_ADS
		AKUAndroidAmazonAdsAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_CHARTBOOST
		AKUAndroidChartBoostAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_CRITTERCISM
		AKUAndroidCrittercismAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_FACEBOOK
		AKUAndroidFacebookAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_FLURRY
		AKUAndroidFlurryAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_GAMECIRCLE
		AKUAndroidGameCircleAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_GOOGLE_PLAY_SERVICES
		AKUAndroidGooglePlayServicesAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_HEYZAP
		AKUAndroidHeyZapAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_OBB_DOWNLOADER
		AKUAndroidObbDownloaderAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_REVMOB
		AKUAndroidRevMobAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_STARTAPP
		AKUAndroidStartAppAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_TAPJOY
		AKUAndroidTapjoyAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_TWITTER
		AKUAndroidTwitterAppInitialize ();
	#endif

	#if AKU_WITH_ANDROID_VUNGLE
		AKUAndroidVungleAppInitialize ();
	#endif

}

//----------------------------------------------------------------//
void AKUModulesAndroidContextInitialize () {

	#if AKU_WITH_ANDROID_ADCOLONY
		AKUAndroidAdColonyContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_ADMOB
		AKUAndroidAdMobContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_AMAZON_ADS
		AKUAndroidAmazonAdsContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_CHARTBOOST
		AKUAndroidChartBoostContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_CRITTERCISM
		AKUAndroidCrittercismContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_FACEBOOK
		AKUAndroidFacebookContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_FLURRY
		AKUAndroidFlurryContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_GAMECIRCLE
		AKUAndroidGameCircleContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_GOOGLE_PLAY_SERVICES
		AKUAndroidGooglePlayServicesContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_HEYZAP
		AKUAndroidHeyZapContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_OBB_DOWNLOADER
		AKUAndroidObbDownloaderContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_REVMOB
		AKUAndroidRevMobContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_STARTAPP
		AKUAndroidStartAppContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_TAPJOY
		AKUAndroidTapjoyContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_TWITTER
		AKUAndroidTwitterContextInitialize ();
	#endif

	#if AKU_WITH_ANDROID_VUNGLE
		AKUAndroidVungleContextInitialize ();
	#endif

}

//----------------------------------------------------------------//
void AKUModulesAndroidPause ( bool pause ) {
	UNUSED ( pause );
}


//----------------------------------------------------------------//
void AKUModulesAndroidUpdate () {
}
