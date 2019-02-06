project (libmoai)

add_subdirectory ( config )
set ( LUA_LIB_DIR "" )
set ( FMOD_LIB_DIR "" )
add_subdirectory ( ../third-party third-party )
set ( LUA_LIB_DIR ${LUA_LIB_DIR} PARENT_SCOPE )
set ( FMOD_LIB_DIR ${FMOD_LIB_DIR} PARENT_SCOPE )

add_subdirectory ( zlcore )

add_subdirectory ( moai-core )
add_subdirectory ( moai-util )
add_subdirectory ( moai-sim )

if ( MOAI_CRYPTO )
  add_subdirectory ( moai-crypto )
endif ( MOAI_CRYPTO )

add_subdirectory ( moai-box2d )

if ( MOAI_HTTP_CLIENT )
  add_subdirectory ( moai-http-client )
endif ( MOAI_HTTP_CLIENT )

if ( MOAI_HTTP_SERVER )
  add_subdirectory ( moai-http-server )
endif ( MOAI_HTTP_SERVER )

add_subdirectory ( moai-luaext )

if ( MOAI_FMOD_STUDIO )
    add_subdirectory ( moai-fmod-studio )
endif ( MOAI_FMOD_STUDIO )

if ( MOAI_UNTZ )
    add_subdirectory ( moai-untz )
    add_subdirectory ( moai-audiosampler )
endif ( MOAI_UNTZ )

if ( MOAI_SPINE )
    add_subdirectory ( moai-spine )
endif ( MOAI_SPINE )

if ( MOAI_TEST )
    add_subdirectory ( moai-test )
endif ( MOAI_TEST )

if ( MOAI_PLUGINS )
    add_subdirectory ( moai-plugins )
endif ( MOAI_PLUGINS )

#platform specific libs
if ( BUILD_LINUX OR BUILD_OSX OR BUILD_WINDOWS )
    add_subdirectory ( moai-sdl )
endif ( BUILD_LINUX OR BUILD_OSX OR BUILD_WINDOWS )

if ( BUILD_OSX OR BUILD_IOS )
    add_subdirectory ( moai-apple )
endif ( BUILD_OSX OR BUILD_IOS )

if ( BUILD_IOS )
    add_subdirectory ( moai-iphone )
endif ( BUILD_IOS )

if ( BUILD_ANDROID )
    add_subdirectory ( moai-android )
endif (BUILD_ANDROID )
