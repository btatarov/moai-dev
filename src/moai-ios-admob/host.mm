// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-ios-admob/host.h>
#include <moai-ios-admob/MOAIAdMobIOS.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUIosAdMobAppFinalize () {
}

//----------------------------------------------------------------//
void AKUIosAdMobAppInitialize () {
}

//----------------------------------------------------------------//
void AKUIosAdMobContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIAdMobIOS );
}
