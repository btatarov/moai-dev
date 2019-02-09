#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

	include $(CLEAR_VARS)

	LOCAL_MODULE 		:= png
	LOCAL_ARM_MODE 		:= $(MY_ARM_MODE)
	LOCAL_CFLAGS		:= -include $(MOAI_SDK_HOME)/src/zl-vfs/zl_replace.h
	LOCAL_CFLAGS		+= -fvisibility=hidden

	LOCAL_C_INCLUDES 	:= $(MY_HEADER_SEARCH_PATHS)
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/png.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngerror.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngget.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngmem.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngpread.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngread.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngrio.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngrtran.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngrutil.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngset.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngtest.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngtrans.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngwio.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngwrite.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngwtran.c
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/3rdparty/libpng-1.4.19/pngwutil.c

	include $(BUILD_STATIC_LIBRARY)
