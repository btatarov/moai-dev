cmake_minimum_required ( VERSION 2.8.5 )

project ( curl )


  set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DBUILDING_LIBCURL -DCURL_DISABLE_LDAP -DCURL_DISABLE_NTLM -DUSE_MBEDTLS"  )
  set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DBUILDING_LIBCURL -DCURL_DISABLE_LDAP -DCURL_DISABLE_NTLM -DUSE_MBEDTLS" )

  if ( BUILD_ANDROID OR BUILD_IOS )
    set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DUSE_ARES" )
    set ( USE_ARES true )
  endif (BUILD_ANDROID OR BUILD_IOS)

  if (BUILD_LINUX)
      set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS}  -DHAVE_CONFIG_H"  )
      set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DHAVE_CONFIG_H" )
      set ( CURL_INCLUDES
            "${MOAI_ROOT}/3rdparty/curl-7.66.0/include-linux/"
            "${MOAI_ROOT}/3rdparty/curl-7.66.0/include/"
            "${MOAI_ROOT}/3rdparty/curl-7.66.0/lib/"
       )
      set ( RUN_CURL_CONFIGURE true )
  endif (BUILD_LINUX)

  if (BUILD_WINDOWS)
      set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DWIN32 -D_WINDOWS"  )
      set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DWIN32 -D_WINDOWS" )
      set ( CURL_INCLUDES
          "${MOAI_ROOT}/3rdparty/curl-7.66.0/include-windows/"
          "${MOAI_ROOT}/3rdparty/curl-7.66.0/include/"
          "${MOAI_ROOT}/3rdparty/curl-7.66.0/lib/"
      )
  endif (BUILD_WINDOWS)

  if (BUILD_OSX)
        set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DHAVE_CONFIG_H"  )
        set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DHAVE_CONFIG_H" )
        set ( CURL_INCLUDES
            "${MOAI_ROOT}/3rdparty/curl-7.66.0/include-osx/"
            "${MOAI_ROOT}/3rdparty/curl-7.66.0/include/"
            "${MOAI_ROOT}/3rdparty/curl-7.66.0/lib/"
        )
    endif (BUILD_OSX)

  if (BUILD_HTML)
        set ( CURL_INCLUDES
          "${MOAI_ROOT}/3rdparty/curl-7.66.0/include/"
        )
    endif (BUILD_HTML)


  if (BUILD_ANDROID)
     set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DHAVE_CONFIG_H"  )
     set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DHAVE_CONFIG_H" )
     set ( CURL_INCLUDES
         "${MOAI_ROOT}/3rdparty/curl-7.66.0/include-osx/"
         "${MOAI_ROOT}/3rdparty/curl-7.66.0/include/"
         "${MOAI_ROOT}/3rdparty/curl-7.66.0/lib"
        )
  endif (BUILD_ANDROID)

  if (BUILD_IOS)
    set ( CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -DHAVE_CONFIG_H"  )
    set ( CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -DHAVE_CONFIG_H" )
    set ( CURL_INCLUDES
        "${MOAI_ROOT}/3rdparty/curl-7.66.0/include-ios/"
        "${MOAI_ROOT}/3rdparty/curl-7.66.0/include/"
        "${MOAI_ROOT}/3rdparty/curl-7.66.0/lib"
    )
  endif (BUILD_IOS)

  set (CURL_HEADERS "")

  set ( CMAKE_CURRENT_SOURCE_DIR "${MOAI_ROOT}/3rdparty/curl-7.66.0/lib" )

  file ( GLOB CURL_SOURCES
      "${CMAKE_CURRENT_SOURCE_DIR}/*.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/vauth/*.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/vquic/*.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/vssh/*.c"
      "${CMAKE_CURRENT_SOURCE_DIR}/vtls/*.c"
  )

  add_library(curl STATIC ${CURL_SOURCES} ${CURL_HEADERS})
  target_include_directories (curl PUBLIC "$<BUILD_INTERFACE:${CURL_INCLUDES}>" )
  target_link_libraries( curl zlib mbedtls )
  set_target_properties( curl PROPERTIES FOLDER Third-Party )
  target_compile_definitions( curl PUBLIC CURL_STATICLIB=1 )

  if (USE_ARES)
      target_link_libraries( curl cares )
  endif (USE_ARES)

  if (BUILD_WINDOWS)
      target_link_libraries( curl ws2_32 )
  endif (BUILD_WINDOWS)

  install(TARGETS curl EXPORT libmoai ARCHIVE DESTINATION lib)
