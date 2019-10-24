#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

	include $(CLEAR_VARS)

	LOCAL_MODULE 		:= lua
	LOCAL_ARM_MODE 		:= $(MY_ARM_MODE)
	LOCAL_CFLAGS		:= -include $(MOAI_SDK_HOME)/src/zl-vfs/zl_replace.h
	LOCAL_CFLAGS		+= -fvisibility=hidden

	LOCAL_C_INCLUDES    := $(MY_HEADER_SEARCH_PATHS)
	LOCAL_SRC_FILES     := $(MOAI_SDK_HOME)/3rdparty/LuaJIT-2.1.0-beta3/lib/android/$(TARGET_ARCH_ABI)/libluajit.a

	include $(PREBUILT_STATIC_LIBRARY)
