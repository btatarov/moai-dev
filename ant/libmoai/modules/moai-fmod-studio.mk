#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

	include $(CLEAR_VARS)

	LOCAL_MODULE 		:= moai-fmod-studio
	LOCAL_ARM_MODE 		:= $(MY_ARM_MODE)
	LOCAL_CFLAGS		:= $(MY_LOCAL_CFLAGS) -include $(MOAI_SDK_HOME)/src/zl-vfs/zl_replace.h -fvisibility=hidden

	LOCAL_C_INCLUDES 	:= $(MY_HEADER_SEARCH_PATHS)
	LOCAL_C_INCLUDES 	+= $(MOAI_SDK_HOME)/3rdparty/fmod/headers
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/src/moai-fmod-studio/host.cpp
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/src/moai-fmod-studio/MOAIFmodStudio.cpp
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/src/moai-fmod-studio/MOAIFmodStudioChannel.cpp
	LOCAL_SRC_FILES 	+= $(MOAI_SDK_HOME)/src/moai-fmod-studio/MOAIFmodStudioSound.cpp

	include $(BUILD_STATIC_LIBRARY)
