ANDROID_PLATFORM_TARGET     = 'android-19'

MODULES = {

    moai = {
		src		= MOAI_SDK_HOME .. 'src/moai-android',
		bin		= MOAI_SDK_HOME .. 'ant/libmoai/libs/<arch>/libmoai.so',
	},

	contrib = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/contrib',
        bin     = MOAI_SDK_HOME .. 'ant/libmoai/libs/<arch>/libgnustl_shared.so' -- HACK: import gnustl
	},

    google_play_services = {
		lib		= MOAI_SDK_HOME .. '3rdparty-android/google-play-services-8.4.0',
		src		= MOAI_SDK_HOME .. 'src/moai-android-google-play-services',
	},

    fmod = {
        lib     = MOAI_SDK_HOME .. '3rdparty-android/fmod',
        bin     = MOAI_SDK_HOME .. 'ant/libmoai/libs/<arch>/libfmod.so'
    },
    --
	-- google_billing	= {
	-- 	lib		= MOAI_SDK_HOME .. '3rdparty-android/google-billing-v3',
	-- 	src		= MOAI_SDK_HOME .. 'src/moai-android-google-billing',
	-- },
}
