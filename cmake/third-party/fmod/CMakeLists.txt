cmake_minimum_required ( VERSION 2.8.5 )
project ( fmod )

set ( CMAKE_CURRENT_SOURCE_DIR "${MOAI_ROOT}/3rdparty/fmod/" )

set ( FMOD_LIB_ROOT "${MOAI_ROOT}/3rdparty/fmod/lib" )

if ( BUILD_WINDOWS )
    if ( MSVC )
        set ( FMOD_LIB ${FMOD_LIB_ROOT}/windows/fmod_vc.lib )
        set ( FMOD_LIB_DIR "${FMOD_LIB_ROOT}/windows/" )
        set ( FMOD_LIB_NAME "fmod_vc.lib" )
    else ( MSVC )
        set ( FMOD_LIB ${FMOD_LIB_ROOT}/windows/fmod.dll )
        set ( FMOD_LIB_DIR "${FMOD_LIB_ROOT}/windows/" )
        set ( FMOD_LIB_NAME "fmod.dll" )
    endif ( MSVC )
elseif ( BUILD_OSX )
    set ( FMOD_LIB ${FMOD_LIB_ROOT}/osx/libfmod.dylib )
    set ( FMOD_LIB_DIR "${FMOD_LIB_ROOT}/osx/" )
    set ( FMOD_LIB_NAME "libfmod.dylib" )
elseif ( BUILD_ANDROID )
    set (FMOD_LIB "${FMOD_LIB_ROOT}/android/${ANDROID_ABI}/libfmod.so" )
    set ( FMOD_LIB_DIR "${FMOD_LIB_ROOT}/android/${ANDROID_ABI}/" )
    set ( FMOD_LIB_NAME "libfmod.so" )
endif()

if ( BUILD_IOS )
    set ( FMOD_LIB "${FMOD_LIB_ROOT}/ios/libfmod_iphoneos.a" )
    set ( FMOD_LIB_DIR "${FMOD_LIB_ROOT}/ios/" )
    set ( FMOD_LIB_NAME "libfmod_iphoneos.a" )
endif ( BUILD_IOS )

set ( FMOD_INCLUDES
  "${MOAI_ROOT}/3rdparty/fmod/headers/"
)

set ( FMOD_HEADERS "${FMOD_INCLUDES}" PARENT_SCOPE )
set ( FMOD_LIB_DIR "${FMOD_LIB_DIR}" PARENT_SCOPE )
set ( FMOD_LIB "${FMOD_LIB_NAME}" PARENT_SCOPE )

file ( GLOB FMOD_HEADERS "${FMOD_INCLUDES}/*.h" )

add_custom_command(OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${FMOD_LIB_NAME}"
    COMMAND ${CMAKE_COMMAND} -E copy "${FMOD_LIB_DIR}/${FMOD_LIB_NAME}" "${CMAKE_CURRENT_BINARY_DIR}/${FMOD_LIB_NAME}"
)

add_custom_target ( fmod DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${FMOD_LIB_NAME}" )

set_target_properties ( fmod PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${FMOD_LIB_NAME}" INSTALL_RPATH "@loader_path/../lib" )

install ( FILES "${CMAKE_CURRENT_BINARY_DIR}/${FMOD_LIB_NAME}" DESTINATION lib )

install ( FILES
     ${FMOD_HEADERS}
     DESTINATION include/fmod
 )
