#================================================================#
# Copyright (c) 2010-2011 Zipline Games, Inc.
# All Rights Reserved.
# http://getmoai.com
#================================================================#

	APP_ABI 								:= @MY_ARM_ARCH@
	APP_CFLAGS							:= -w -DANDROID_NDK -DDISABLE_IMPORTGL -lEGL
	APP_PLATFORM 						:= @MY_APP_PLATFORM@
	APP_STL 								:= gnustl_shared
	NDK_TOOLCHAIN_VERSION		:= 4.9
