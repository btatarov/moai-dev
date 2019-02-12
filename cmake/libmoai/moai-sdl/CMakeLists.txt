cmake_minimum_required ( VERSION 2.8.5 )
project ( moai-sdl )


set ( MOAI_SDL_INCLUDES
  "${MOAI_ROOT}/src/"
  "${SDL_HEADERS}"
  "${CMAKE_BINARY_DIR}/libmoai/config"
)

include_directories ( ${MOAI_SDL_INCLUDES} )

set ( CMAKE_CURRENT_SOURCE_DIR "${MOAI_ROOT}/src/moai-sdl/" )

# Use all cpp files in directory as source code
file ( GLOB MOAI_SDL_SRC "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp" "${CMAKE_CURRENT_SOURCE_DIR}/*.h" )

include_directories ( ${MOAI_SDL_INCLUDES} )

add_library ( moai-sdl STATIC ${MOAI_SDL_SRC} )

link_directories ( "${SDL_LIB_DIR}" )
target_link_libraries ( moai-sdl moai-core moai-util ${SDL_LIB} )
add_dependencies ( moai-sdl SDL2 )

target_include_directories (moai-sdl PUBLIC
    "$<BUILD_INTERFACE:${MOAI_SDL_INCLUDES}>"
     $<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include>
    "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include/SDL2>"
)

set_target_properties(moai-sdl PROPERTIES FOLDER Modules)

install(TARGETS moai-sdl EXPORT libmoai ARCHIVE DESTINATION lib)

install(DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION include/moai-sdl FILES_MATCHING PATTERN "*.h")
