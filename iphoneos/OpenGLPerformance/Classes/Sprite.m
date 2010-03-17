//
//  Sprite.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 26/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Sprite.h"


@implementation Sprite

@synthesize x, y, height, width, xdirection, ydirection;

- (Sprite *) init 
{
	self.x = 0;
	self.y = 0;
	width = 0;
	height = 0;
	self.xdirection = 1;
	self.ydirection = 1;
	return self;
}

- (void) draw 
{
}

@end
