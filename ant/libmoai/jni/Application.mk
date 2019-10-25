#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

APP_ABI 					:= armeabi-v7a arm64-v8a x86 x86_64
APP_CFLAGS					:= -w -DANDROID_NDK -DDISABLE_IMPORTGL -lEGL # -g -O0 -DDEBUG -D_DEBUG
APP_PLATFORM 				:= android-15
APP_STL 					:= gnustl_static
NDK_TOOLCHAIN_VERSION		:= 4.9
# APP_OPTIM 					:= debug
