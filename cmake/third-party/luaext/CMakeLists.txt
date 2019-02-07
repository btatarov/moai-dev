cmake_minimum_required ( VERSION 2.8.5 )
project ( luaext )

add_subdirectory ( luafilesystem )
add_subdirectory ( luasql )
add_subdirectory ( luacurl )

if (MOAI_LIBCRYPTO)
  add_subdirectory ( luacrypto )
endif (MOAI_LIBCRYPTO)

add_subdirectory ( luasocket )
