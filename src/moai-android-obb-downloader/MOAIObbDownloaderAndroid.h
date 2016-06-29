// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#ifndef	MOAIOBBDOWNLOADERANDROID_H
#define	MOAIOBBDOWNLOADERANDROID_H

#include <moai-core/headers.h>
#include <moai-android/JniUtils.h>

//================================================================//
// MOAIObbDownloaderAndroid
//================================================================//
class MOAIObbDownloaderAndroid :
	public MOAIGlobalClass < MOAIObbDownloaderAndroid, MOAIGlobalEventSource >,
	public JniUtils {
private:

	jmethodID	mJava_Init;

	//----------------------------------------------------------------//
	static int	_init		( lua_State* L );

public:

	DECL_LUA_SINGLETON ( MOAIObbDownloaderAndroid );

	enum {
		DOWNLOAD_COMPLETED,
	};

	//----------------------------------------------------------------//
			MOAIObbDownloaderAndroid	();
			~MOAIObbDownloaderAndroid	();
	void	RegisterLuaClass			( MOAILuaState& state );
};


#endif  //MOAIOBBDOWNLOADERANDROID_H
