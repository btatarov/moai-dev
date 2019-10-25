#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

include $(CLEAR_VARS)

LOCAL_MODULE 			:= curl
LOCAL_ARM_MODE 			:= $(MY_ARM_MODE)
LOCAL_CFLAGS 			:= -DHAVE_CONFIG_H  -DCURL_STATICLIB -DUSE_SSL -DUSE_MBEDTLS  -DBUILDING_LIBCURL -DUSE_ARES -DCARES_STATICLIB -DCURL_DISABLE_LDAP -DCURL_DISABLE_NTLM  -libcares
LOCAL_CFLAGS			+= -include $(MOAI_SDK_HOME)/src/zl-vfs/zl_replace.h
LOCAL_CFLAGS			+= -fvisibility=hidden

LOCAL_C_INCLUDES 		:= $(MY_HEADER_SEARCH_PATHS)
LOCAL_C_INCLUDES		+= $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/include-android
LOCAL_C_INCLUDES		+= $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/lib

LOCAL_SRC_FILES 		+= $(wildcard $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/lib/*.c)
LOCAL_SRC_FILES 		+= $(wildcard $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/lib/vauth/*.c)
LOCAL_SRC_FILES			+= $(wildcard $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/lib/vquic/*.c)
LOCAL_SRC_FILES			+= $(wildcard $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/lib/vssh/*.c)
LOCAL_SRC_FILES			+= $(wildcard $(MOAI_SDK_HOME)/3rdparty/curl-7.66.0/lib/vtls/*.c)

include $(BUILD_STATIC_LIBRARY)
