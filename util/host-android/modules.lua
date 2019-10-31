MODULES = {

    adcolony = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/adcolony-4.1.0',
        src		= MOAI_SDK_HOME .. 'src/moai-android-adcolony',
    },

    admob = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/admob', -- same as gps 8.4.0
        src		= MOAI_SDK_HOME .. 'src/moai-android-admob',
    },

    amazon_ads = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/amazon-ads',
        src		= MOAI_SDK_HOME .. 'src/moai-android-amazonads',
    },

    amazon_billing = {
        lib     = MOAI_SDK_HOME .. "3rdparty-android/amazon-billing-v2",
        src		= MOAI_SDK_HOME .. 'src/moai-android-amazon-billing',
    },

    amazon_gamecircle = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/amazon-gamecircle',
		src		= MOAI_SDK_HOME .. 'src/moai-android-gamecircle',
        project = true,
	},

    applovin = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/applovin-7.3.2',
        src		= MOAI_SDK_HOME .. 'src/moai-android-applovin',
    },

    chartboost = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/chartboost-6.4.1',
        src		= MOAI_SDK_HOME .. 'src/moai-android-chartboost',
    },

    contrib = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/contrib',
    -- bin   = MOAI_SDK_HOME .. 'ant/libmoai/libs/<arch>/libgnustl_shared.so', -- HACK: import gnustl
	},

    crittercism = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/crittercism-5.5.5',
		src		= MOAI_SDK_HOME .. 'src/moai-android-crittercism',
	},

    google_billing	= {
    	lib		= MOAI_SDK_HOME .. '3rdparty-android/google-billing-v3',
    	src		= MOAI_SDK_HOME .. 'src/moai-android-google-billing',
    },

    google_play_services = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/google-play-services-r29',
		src		= MOAI_SDK_HOME .. 'src/moai-android-google-play-services',
	},

    facebook = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/facebook-4.5.1',
		src		= MOAI_SDK_HOME .. 'src/moai-android-facebook',
        project = true,
	},

    fmod = {
        lib     = MOAI_SDK_HOME .. '3rdparty-android/fmod',
        bin     = MOAI_SDK_HOME .. 'ant/libmoai/libs/<arch>/libfmod.so',
    },

    heyzap = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/heyzap-9.13.3',
        src		= MOAI_SDK_HOME .. 'src/moai-android-heyzap',
    },

    moai = {
		src		= MOAI_SDK_HOME .. 'src/moai-android',
		bin		= MOAI_SDK_HOME .. 'ant/libmoai/libs/<arch>/libmoai.so',
	},

    obb_downloader = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/obb-downloader',
        src		= MOAI_SDK_HOME .. 'src/moai-android-obb-downloader',
        project = true,
    },

    revmob = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/revmob-10.0.0',
        src		= MOAI_SDK_HOME .. 'src/moai-android-revmob',
    },

    startapp = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/startapp-3.6.6',
        src		= MOAI_SDK_HOME .. 'src/moai-android-startapp',
    },

    twitter = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/twitter4j-4.0.4',
		src		= MOAI_SDK_HOME .. 'src/moai-android-twitter',
	},

    vungle = {
        lib		= MOAI_SDK_HOME .. '3rdparty-android/vungle-6.3.17',
        src		= MOAI_SDK_HOME .. 'src/moai-android-vungle',
    },

}
