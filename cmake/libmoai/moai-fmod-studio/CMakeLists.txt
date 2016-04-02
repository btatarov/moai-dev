cmake_minimum_required ( VERSION 2.8.5 )
project ( moai-fmod-studio )

set ( CMAKE_CURRENT_SOURCE_DIR "${MOAI_ROOT}/src/moai-fmod-studio/" )

set ( MOAI_FMOD_INCLUDES
    "${MOAI_ROOT}/src/"
    "${CMAKE_BINARY_DIR}/libmoai/config"
    "${MOAI_ROOT}/src/moai-fmod-studio/"
)

# Use all cpp files in directory as source code
file ( GLOB MOAI_FMOD_SRC
    "${CMAKE_CURRENT_SOURCE_DIR}/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/*.h"
)

add_library ( moai-fmod-studio STATIC ${MOAI_FMOD_SRC} )

set ( BUILD_INCLUDES ${MOAI_FMOD_INCLUDES} ${FMOD_HEADERS} )

target_include_directories ( moai-fmod-studio PUBLIC
    "$<BUILD_INTERFACE:${BUILD_INCLUDES}>"
    "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include>"
    "$<INSTALL_INTERFACE:$<INSTALL_PREFIX>/include/fmod>"
)

link_directories ( "${FMOD_LIB_DIR}" )
target_link_libraries ( moai-fmod-studio moai-core moai-util moai-sim zlcore ${FMOD_LIB} )
add_dependencies ( moai-fmod-studio fmod )

set_target_properties ( moai-fmod-studio PROPERTIES FOLDER Modules )

install ( TARGETS moai-fmod-studio EXPORT libmoai ARCHIVE DESTINATION lib )

install ( DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR} DESTINATION include/moai-fmod-studio
          FILES_MATCHING PATTERN "*.h" )
