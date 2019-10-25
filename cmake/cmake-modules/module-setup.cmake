#
# Optional modules
set (CMAKE_MODULE_PATH "${CMAKE_MODULE_PATH};${CMAKE_CURRENT_SOURCE_DIR}")
include(module-config)


if (PLUGIN_DIR)
  set (MOAI_PLUGINS TRUE)
endif (PLUGIN_DIR)


#
# Moai SDK Extensions
#




macro(SETUP_MODULE module_name flag_name)
  if (${module_name})
    set ( ${flag_name} 1)
    set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D${flag_name}=1" )
    set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D${flag_name}=1" )
  else ()
    set ( ${flag_name} 0)
    set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -D${flag_name}=0" )
    set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -D${flag_name}=0" )
  endif(${module_name})
endmacro(SETUP_MODULE)

#setup our defines for optional modules.
#if we have a prebuilt library, it is too late for most of these as they will already exist in the library
#instead we rely on the moai_config.h that was generated during the lib build phase.
if (NOT LIB_PATH)

SETUP_MODULE(MOAI_APPLE MOAI_WITH_APPLE)
SETUP_MODULE(MOAI_APPLE AKU_WITH_APPLE)

SETUP_MODULE(MOAI_SDL MOAI_WITH_SDL)
SETUP_MODULE(MOAI_SDL AKU_WITH_SDL)

SETUP_MODULE(MOAI_BOX2D MOAI_WITH_BOX2D)
SETUP_MODULE(MOAI_BOX2D AKU_WITH_BOX2D)

SETUP_MODULE(MOAI_FMOD_STUDIO MOAI_WITH_FMOD_STUDIO)
SETUP_MODULE(MOAI_FMOD_STUDIO AKU_WITH_FMOD_STUDIO)

SETUP_MODULE(MOAI_CURL MOAI_WITH_LIBCURL)

SETUP_MODULE(MOAI_UNTZ MOAI_WITH_UNTZ)
SETUP_MODULE(MOAI_UNTZ AKU_WITH_UNTZ)

SETUP_MODULE(MOAI_SPINE MOAI_WITH_SPINE)
SETUP_MODULE(MOAI_SPINE AKU_WITH_SPINE)

SETUP_MODULE(MOAI_TINYXML MOAI_WITH_TINYXML)

SETUP_MODULE(MOAI_HTTP_CLIENT MOAI_WITH_HTTP_CLIENT)
SETUP_MODULE(MOAI_HTTP_CLIENT AKU_WITH_HTTP_CLIENT)

SETUP_MODULE(MOAI_HTTP_SERVER AKU_WITH_HTTP_SERVER)

SETUP_MODULE(MOAI_EXPAT MOAI_WITH_EXPAT)

SETUP_MODULE(MOAI_EXPAT MOAI_WITH_EXPAT)

SETUP_MODULE(MOAI_CRYPTO AKU_WITH_CRYPTO)

SETUP_MODULE(MOAI_OPENSSL MOAI_WITH_OPENSSL)

SETUP_MODULE(MOAI_FREETYPE MOAI_WITH_FREETYPE)

SETUP_MODULE(MOAI_LUAEXT AKU_WITH_LUAEXT)
SETUP_MODULE(MOAI_LUAEXT MOAI_WITH_LUAEXT)

SETUP_MODULE(MOAI_SQLITE3 MOAI_WITH_SQLITE)

SETUP_MODULE(MOAI_JSON MOAI_WITH_JANSSON)
SETUP_MODULE(MOAI_SFMT MOAI_WITH_SFMT)
SETUP_MODULE(MOAI_PNG MOAI_WITH_LIBPNG)
SETUP_MODULE(MOAI_PVR MOAI_WITH_LIBPVR)
SETUP_MODULE(MOAI_JPG MOAI_WITH_LIBJPG)
SETUP_MODULE(MOAI_VORBIS MOAI_WITH_VORBIS)
SETUP_MODULE(MOAI_OGG MOAI_WITH_OGG)

SETUP_MODULE(MOAI_MONGOOSE MOAI_WITH_MONGOOSE)
SETUP_MODULE(MOAI_LUAJIT MOAI_WITH_LUAJIT)
SETUP_MODULE(MOAI_WEBP MOAI_WITH_WEBP)

SETUP_MODULE(MOAI_AUDIO_SAMPLER AKU_WITH_AUDIO_SAMPLER)

endif (NOT LIB_PATH)

SETUP_MODULE(MOAI_PLUGINS AKU_WITH_PLUGINS)
SETUP_MODULE(MOAI_TEST AKU_WITH_TEST)


#Flags for optional modules

FOREACH(DISABLED ${DISABLED_EXT} )
   set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DDISABLE_${DISABLED}"  )
   set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DDISABLE_${DISABLED}"  )
   set ( DISABLE_${DISABLED} TRUE )
ENDFOREACH()
