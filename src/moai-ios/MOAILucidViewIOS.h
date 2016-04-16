// Copyright (c) 2016 Bogdan Tatarov
// https://github.com/btatarov
// MIT License

#ifndef	MOAILUCIDVIEWIOS_H
#define	MOAILUCIDVIEWIOS_H

#import <UIKit/UIKit.h>

//================================================================//
// MOAILucidView
//================================================================//
/**
	Provides a transparent wrapper that passes the touches through
	to a parent view but processes that ones that happen in child
	views. Useful for putting banners or other gui stuff on top of
	Moai's main view.
*/

@interface MOAILucidViewIOS : UIView

@end

#endif
