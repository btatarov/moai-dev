// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-ios-startapp/host.h>
#include <moai-ios-startapp/MOAIStartAppIOS.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUIosStartAppAppFinalize () {
}

//----------------------------------------------------------------//
void AKUIosStartAppAppInitialize () {
}

//----------------------------------------------------------------//
void AKUIosStartAppContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIStartAppIOS );
}
