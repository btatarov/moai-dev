cmake_minimum_required ( VERSION 2.8.5 )
project ( spine )

set ( CMAKE_CURRENT_SOURCE_DIR "${MOAI_ROOT}/3rdparty/spine-c/" )
set ( SPINE_INCLUDES "${MOAI_ROOT}/3rdparty/spine-c/include" )

set ( SPINE_SOURCE_DIR "${CMAKE_CURRENT_SOURCE_DIR}" )

file ( GLOB SPINE_SOURCES
    "${SPINE_SOURCE_DIR}/src/spine/*.c"
    "${SPINE_SOURCE_DIR}/src/spine/*.h"
    "${SPINE_SOURCE_DIR}/include/spine/*.h"
)

add_library ( spine STATIC ${SPINE_SOURCES} )

target_include_directories ( spine PUBLIC "$<BUILD_INTERFACE:${SPINE_INCLUDES}>" )
set_target_properties ( spine PROPERTIES FOLDER Third-Party )
install ( TARGETS spine EXPORT libmoai ARCHIVE DESTINATION lib )
