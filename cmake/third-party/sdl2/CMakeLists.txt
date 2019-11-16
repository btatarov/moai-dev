cmake_minimum_required ( VERSION 2.8.5 )
project ( sdl2 )

set ( CMAKE_CURRENT_SOURCE_DIR "${MOAI_ROOT}/3rdparty/sdl2-2.0.10/" )

set ( SDL_LIB_ROOT "${MOAI_ROOT}/3rdparty/sdl2-2.0.10/lib" )
set ( SDL_LIB_RPATH "" )

if ( BUILD_WINDOWS )
    if ( MSVC )
        set ( SDL_LIB ${SDL_LIB_ROOT}/windows/SDL2.lib )
        set ( SDL_LIB_DIR "${SDL_LIB_ROOT}/windows/" )
        set ( SDL_LIB_NAME "SDL2.lib" )
    else ( MSVC )
        set ( SDL_LIB ${SDL_LIB_ROOT}/windows/SDL2.dll )
        set ( SDL_LIB_DIR "${SDL_LIB_ROOT}/windows/" )
        set ( SDL_LIB_NAME "SDL2.dll" )
    endif ( MSVC )
elseif ( BUILD_OSX )
    set ( SDL_LIB ${SDL_LIB_ROOT}/osx/libSDL2.dylib )
    set ( SDL_LIB_DIR "${SDL_LIB_ROOT}/osx/" )
    set ( SDL_LIB_NAME "libSDL2.dylib" )
    set ( SDL_LIB_RPATH "@loader_path/../lib" )
elseif ( BUILD_LINUX )
    set ( SDL_LIB "${SDL_LIB_ROOT}/linux/libSDL2-2.0.so.0" )
    set ( SDL_LIB_DIR "${SDL_LIB_ROOT}/linux/" )
    set ( SDL_LIB_NAME "libSDL2.so" )
    set ( SDL_LIB_RPATH "$ORIGIN/../lib" )
endif ()


set ( SDL_INCLUDES
  "${MOAI_ROOT}/3rdparty/sdl2-2.0.10/include/"
)

set ( SDL_HEADERS "${SDL_INCLUDES}" PARENT_SCOPE )
set ( SDL_LIB_DIR "${SDL_LIB_DIR}" PARENT_SCOPE )
set ( SDL_LIB "${SDL_LIB_NAME}" PARENT_SCOPE )

add_custom_command ( OUTPUT "${CMAKE_CURRENT_BINARY_DIR}/${SDL_LIB_NAME}"
    COMMAND ${CMAKE_COMMAND} -E copy "${SDL_LIB_DIR}/${SDL_LIB_NAME}" "${CMAKE_CURRENT_BINARY_DIR}/${SDL_LIB_NAME}"
)

add_custom_target ( SDL2 DEPENDS "${CMAKE_CURRENT_BINARY_DIR}/${SDL_LIB_NAME}" )

set_target_properties ( SDL2 PROPERTIES
  IMPORTED_LOCATION "${CMAKE_CURRENT_BINARY_DIR}/${SDL_LIB_NAME}"
  INSTALL_RPATH "${LIB_RPATH}"
)

file ( GLOB SDL_HEADERS "${SDL_INCLUDES}/*.h" )
install ( FILES ${SDL_HEADERS} DESTINATION include/sdl2 )

if ( BUILD_LINUX )
    install ( FILES "${SDL_LIB}" DESTINATION lib )
else ()
    install ( FILES "${CMAKE_CURRENT_BINARY_DIR}/${SDL_LIB_NAME}" DESTINATION lib )
endif ( BUILD_LINUX )
