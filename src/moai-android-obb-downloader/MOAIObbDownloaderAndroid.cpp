// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com


#include "moai-core/pch.h"
#include "moai-sim/pch.h"

#include <moai-android/moaiext-jni.h>
#include <moai-android-obb-downloader/MOAIObbDownloaderAndroid.h>

//================================================================//
// lua
//================================================================//

//----------------------------------------------------------------//
int MOAIObbDownloaderAndroid::_init ( lua_State* L ) {

	MOAI_JAVA_LUA_SETUP ( MOAIObbDownloaderAndroid, "" )

	self->CallStaticVoidMethod ( self->mJava_Init );

	return 0;
}


//================================================================//
// MOAIObbDownloaderAndroid
//================================================================//

//----------------------------------------------------------------//
MOAIObbDownloaderAndroid::MOAIObbDownloaderAndroid () {

	RTTI_SINGLE ( MOAIGlobalEventSource )

	this->SetClass ( "com/ziplinegames/moai/MoaiObbDownloader" );

	this->mJava_Init = this->GetStaticMethod ( "init", "()V" );
}

//----------------------------------------------------------------//
MOAIObbDownloaderAndroid::~MOAIObbDownloaderAndroid () {

}

//----------------------------------------------------------------//
void MOAIObbDownloaderAndroid::RegisterLuaClass ( MOAILuaState& state ) {

	luaL_Reg regTable [] = {
		{ "init",	_init },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}
