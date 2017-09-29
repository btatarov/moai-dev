// Copyright (c) 2010-2011 Zipline Games, Inc. All Rights Reserved.
// http://getmoai.com

#include <moai-ios-applovin/host.h>
#include <moai-ios-applovin/MOAIAppLovinIOS.h>

//================================================================//
// aku
//================================================================//

//----------------------------------------------------------------//
void AKUIosAppLovinAppFinalize () {
}

//----------------------------------------------------------------//
void AKUIosAppLovinAppInitialize () {
}

//----------------------------------------------------------------//
void AKUIosAppLovinContextInitialize () {

	REGISTER_LUA_CLASS ( MOAIAppLovinIOS );
}
