// Copyright (c) 2016 Bogdan Tatarov
// https://github.com/btatarov
// MIT License

#import "MOAILucidViewIOS.h"

@implementation MOAILucidViewIOS

//----------------------------------------------------------------//
-( id )initWithFrame:( CGRect )frame {

	self = [ super initWithFrame:frame ];

	self.opaque = NO;
	self.backgroundColor = [ UIColor clearColor ];

	return self;
}

//----------------------------------------------------------------//
-( id )hitTest:( CGPoint )point withEvent:( UIEvent* )event {

	id hitView = [ super hitTest:point withEvent:event ];

	if (hitView == self) return nil;
	else return hitView;
}

@end
