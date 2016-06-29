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

	state.SetField ( -1, "DOWNLOAD_COMPLETED",	( u32 )DOWNLOAD_COMPLETED );

	luaL_Reg regTable [] = {
		{ "getListener",	&MOAIGlobalEventSource::_getListener < MOAIObbDownloaderAndroid > },
		{ "init",			_init },
		{ "setListener",	&MOAIGlobalEventSource::_setListener < MOAIObbDownloaderAndroid > },
		{ NULL, NULL }
	};

	luaL_register ( state, 0, regTable );
}

//================================================================//
// ObbDownloader JNI methods
//================================================================//

//----------------------------------------------------------------//
extern "C" JNIEXPORT void JNICALL Java_com_ziplinegames_moai_MoaiObbDownloader_AKUInvokeListener ( JNIEnv* env, jclass obj, jint eventID ) {

	ZLLog::LogF ( ZLLog::CONSOLE, "Java_com_ziplinegames_moai_MoaiObbDownloader_AKUInvokeListener\n" );
	MOAIObbDownloaderAndroid::Get ().InvokeListener ( ( u32 )eventID );
}
