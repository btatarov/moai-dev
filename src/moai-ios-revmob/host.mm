// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-ios-revmob/host.h>
#include <moai-ios-revmob/MOAIRevMobIOS.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUIosRevMobAppFinalize () {
}

//----------------------------------------------------------------//
void AKUIosRevMobAppInitialize () {
}

//----------------------------------------------------------------//
void AKUIosRevMobContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIRevMobIOS );
}
