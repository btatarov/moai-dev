CONFIG_NAME = 'MOAI_MODULES'

SETTINGS = {
	LIB_NAME = 'moai',
	MY_ARM_MODE = 'arm',
	MY_ARM_ARCH = 'armeabi-v7a arm64-v8a x86 x86_64',
	MY_APP_PLATFORM = 'android-15',
}

OPTIONAL_COMPONENTS = {
	MOAI_WITH_LUAJIT = false,
}

MODULES = {

	----------------------------------------------------------------
	ADCOLONY = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_ADCOLONY',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-adcolony.mk',
		},

		STATIC_LIBRARIES = 'libmoai-adcolony',
	},

	----------------------------------------------------------------
	ADMOB = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_ADMOB',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-admob.mk',
		},

		STATIC_LIBRARIES = 'libmoai-admob',
	},

	----------------------------------------------------------------
	AMAZON_ADS = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_AMAZON_ADS',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-amazonads.mk',
		},

		STATIC_LIBRARIES = 'libmoai-amazonads',
	},

	----------------------------------------------------------------
	APPLOVIN = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_APPLOVIN',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-applovin.mk',
		},

		STATIC_LIBRARIES = 'libmoai-applovin',
	},

	----------------------------------------------------------------
	BOX2D = {

		MODULE_DEFINE = 'AKU_WITH_BOX2D',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D/Collision/Shapes',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D/Collision',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D/Common',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D/Dynamics',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D/Dynamics/Contacts',
			'$(MOAI_SDK_HOME)/3rdparty/box2d-2.3.0/Box2D/Dynamics/Joints',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-box2d.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-box2d.mk',
		},

		STATIC_LIBRARIES = 'libbox2d libmoai-box2d',
	},

	----------------------------------------------------------------
	CHARTBOOST = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_CHARTBOOST',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-chartboost.mk',
		},

		STATIC_LIBRARIES = 'libmoai-chartboost',
	},

	----------------------------------------------------------------
	CRITTERCISM = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_CRITTERCISM',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-crittercism.mk',
		},

		STATIC_LIBRARIES = 'libmoai-crittercism',
	},

	----------------------------------------------------------------
	CRYPTO = {

		MODULE_DEFINE = 'AKU_WITH_CRYPTO',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/3rdparty/openssl-1.0.2g/include-android',
			'$(MOAI_SDK_HOME)/3rdparty/openssl-1.0.2g/include',
			'$(MOAI_SDK_HOME)/3rdparty/openssl-1.0.2g',
			'$(MOAI_SDK_HOME)/3rdparty/openssl-1.0.2g/crypto',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-crypto.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/zl-crypto.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-crypto.mk',
		},

		STATIC_LIBRARIES = 'libmoai-crypto libzl-crypto libcrypto',
	},

	----------------------------------------------------------------
	GAMECIRCLE = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_GAMECIRCLE',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-gamecircle.mk',
		},

		STATIC_LIBRARIES = 'libmoai-gamecircle',
	},

	----------------------------------------------------------------
	GOOGLE_PLAY_SERVICES = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_GOOGLE_PLAY_SERVICES',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-google-play-services.mk',
		},

		STATIC_LIBRARIES = 'libmoai-googleplayservices',
	},

	----------------------------------------------------------------
	FACEBOOK = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_FACEBOOK',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-facebook.mk',
		},

		STATIC_LIBRARIES = 'libmoai-facebook',
	},

	----------------------------------------------------------------
	FMOD_STUDIO = {

		MODULE_DEFINE = 'AKU_WITH_FMOD_STUDIO',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/src/moai-fmod-studio',
			'$(MOAI_SDK_HOME)/3rdparty/fmod-1.08.00/headers',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-fmod.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-fmod-studio.mk',
		},

		STATIC_LIBRARIES = 'libmoai-fmod-studio',
		SHARED_LIBRARIES = 'fmod',
	},

	----------------------------------------------------------------
	HEYZAP = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_HEYZAP',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-heyzap.mk',
		},

		STATIC_LIBRARIES = 'libmoai-heyzap',
	},

	----------------------------------------------------------------
	HTTP_CLIENT = {

		MODULE_DEFINE = 'AKU_WITH_HTTP_CLIENT',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/3rdparty/c-ares-1.7.5',
			'$(MOAI_SDK_HOME)/3rdparty/c-ares-1.7.5/include-android',
			'$(MOAI_SDK_HOME)/3rdparty/curl-7.19.7/include-android',
			'$(MOAI_SDK_HOME)/3rdparty/openssl-1.0.2g/include-android',
			'$(MOAI_SDK_HOME)/3rdparty/openssl-1.0.2g/include',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-c-ares.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-curl.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-ssl.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-http-client.mk',
		},

		STATIC_LIBRARIES = 'libcares libcurl libssl libmoai-http-client',
	},

	----------------------------------------------------------------
	LUAEXT = {

		MODULE_DEFINE = 'AKU_WITH_LUAEXT',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/3rdparty/luacrypto-0.2.0/src',
			'$(MOAI_SDK_HOME)/3rdparty/luacurl-1.2.1',
			'$(MOAI_SDK_HOME)/3rdparty/luafilesystem-1.5.0/src',
			'$(MOAI_SDK_HOME)/3rdparty/luasocket-2.0.2/src',
			'$(MOAI_SDK_HOME)/3rdparty/luasocket-2.0.2-embed/src',
			'$(MOAI_SDK_HOME)/3rdparty/luasql-2.2.0/src',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-luaext.mk',
		},

		STATIC_LIBRARIES = 'libmoai-luaext',
	},

	----------------------------------------------------------------
	OBB_DOWNLOADER = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_OBB_DOWNLOADER',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-obb-downloader.mk',
		},

		STATIC_LIBRARIES = 'libmoai-obb-downloader',
	},

	----------------------------------------------------------------
	STARTAPP = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_STARTAPP',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-startapp.mk',
		},

		STATIC_LIBRARIES = 'libmoai-startapp',
	},

	----------------------------------------------------------------
	REVMOB = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_REVMOB',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-revmob.mk',
		},

		STATIC_LIBRARIES = 'libmoai-revmob',
	},

	----------------------------------------------------------------
	SIM = {

		MODULE_DEFINE = 'AKU_WITH_SIM',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/3rdparty/freetype-2.4.4/include',
			'$(MOAI_SDK_HOME)/3rdparty/freetype-2.4.4/include/freetype',
			'$(MOAI_SDK_HOME)/3rdparty/freetype-2.4.4/include/freetype2',
			'$(MOAI_SDK_HOME)/3rdparty/freetype-2.4.4/builds',
			'$(MOAI_SDK_HOME)/3rdparty/freetype-2.4.4/src',
			'$(MOAI_SDK_HOME)/3rdparty/freetype-2.4.4/config',
			'$(MOAI_SDK_HOME)/3rdparty/libtess2/Include',
			'$(MOAI_SDK_HOME)/3rdparty/jpeg-8c',
			'$(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19',
			},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-freetype.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-jpg.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-png.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-tess.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-sim.mk',
		},

		STATIC_LIBRARIES = 'libmoai-sim libfreetype libjpg libpng libtess',
	},

	----------------------------------------------------------------
	SPINE = {

		MODULE_DEFINE = 'AKU_WITH_SPINE',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/3rdparty/spine-c/include',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-spine.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-spine.mk',
		},

		STATIC_LIBRARIES = 'libspine libmoai-spine',
	},

	----------------------------------------------------------------
	TWITTER = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_TWITTER',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-twitter.mk',
		},

		STATIC_LIBRARIES = 'libmoai-twitter',
	},

	----------------------------------------------------------------
	UNTZ = {

		MODULE_DEFINE = 'AKU_WITH_UNTZ',

		HEADER_SEARCH_PATHS = {
			'$(MOAI_SDK_HOME)/src/moai-untz',
			'$(MOAI_SDK_HOME)/3rdparty/untz/include',
			'$(MOAI_SDK_HOME)/3rdparty/untz/src',
			'$(MOAI_SDK_HOME)/3rdparty/untz/src/native/android',
			'$(MOAI_SDK_HOME)/3rdparty/libvorbis-1.3.2/include',
			'$(MOAI_SDK_HOME)/3rdparty/libvorbis-1.3.2/lib',
			'$(MOAI_SDK_HOME)/3rdparty/libogg-1.2.2/include',
		},

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-ogg.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-vorbis.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/3rdparty-untz.mk',
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-untz.mk',
		},

		STATIC_LIBRARIES = 'libogg libvorbis libuntz libmoai-untz',
	},

	----------------------------------------------------------------
	UTIL = {

		MODULE_DEFINE = 'AKU_WITH_UTIL',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-util.mk',
		},

		STATIC_LIBRARIES = 'libmoai-util',
	},

	----------------------------------------------------------------
	VUNGLE = {

		MODULE_DEFINE = 'AKU_WITH_ANDROID_VUNGLE',

		INCLUDES = {
			'$(MOAI_SDK_HOME)/ant/libmoai/modules/moai-vungle.mk',
		},

		STATIC_LIBRARIES = 'libmoai-vungle',
	},
}

PLUGINS = {

	----------------------------------------------------------------
	--FOO_PLUGIN = {
	--	HEADER_SEARCH_PATHS		= '$(MOAI_SDK_HOME)/3rdparty/plugins/',
	--	INCLUDES				= '<foo/plugin.h>',
	--	PREFIX					= 'FOOPlugin',
	--},

	----------------------------------------------------------------
	--BAR_PLUGIN = {
	--	HEADER_SEARCH_PATHS		= '$(MOAI_SDK_HOME)/3rdparty/plugins/',
	--	INCLUDES				= '<bar/plugin.h>',
	--	PREFIX					= 'BARPlugin',
	--},
}

EXTERNAL_LIBRARIES = {
	'libcontrib',
	'libexpat',
	'libjson',
	'liblua',
	'libpvr',
	'libmoai-android',
	'libmoai-core',
	'libsfmt',
	'libsqlite',
	'libtinyxml',
	'libzl-core',
	'libzl-gfx',
	'libzl-vfs',
	'libzlib',
}

STATIC_LIBRARIES = {
	-- platform specific
	'libmoai-adcolony',
	'libmoai-admob',
	'libmoai-amazonads',
	'libmoai-applovin',
	'libmoai-chartboost',
	'libmoai-crittercism',
	'libmoai-facebook',
	'libmoai-flurry-analytics',
	'libmoai-gamecircle',
	'libmoai-googleplayservices',
	'libmoai-heyzap',
	'libmoai-obb-downloader',
	'libmoai-revmob',
	'libmoai-startapp',
	'libmoai-twitter',
	'libmoai-vungle',

	-- moai
	'libmoai-box2d',
	'libmoai-http-client',
	'libmoai-fmod-studio',
	'libmoai-luaext',
	'libmoai-untz',
	'libmoai-sim',
	'libmoai-spine',
	'libmoai-crypto',
	'libmoai-util',
	'libmoai-core',

	--zl
	'libzl-gfx',
	'libzl-crypto',
	'libzl-core',

	-- 3rd party
	'libcontrib',
	'libbox2d',
	'libuntz',
	'libvorbis',
	'libogg',
	'libexpat',
	'libjson',
	'liblua',
	'libpvr',
	'libsfmt',
	'libspine',
	'libsqlite',
	'libtinyxml',
	'libfreetype',
	'libjpg',
	'libpng',
	'libtess',

	'libcurl',
	'libcares',
	'libssl',
	'libcrypto',

	--vfs
	'libzl-vfs',
	'libzlib',
}

WHOLE_STATIC_LIBRARIES = {
	'libmoai-android',
	'libmoai-sim',
	'libmoai-core',
	'libcrypto',
}

SHARED_LIBRARIES = {
	'fmod',
}
