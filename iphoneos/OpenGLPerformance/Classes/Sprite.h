//
//  Sprite.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 26/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Sprite : NSObject {

@public
	float x;
	float y;
	float width;
	float height;
	int xdirection;
	int ydirection;
}

@property (nonatomic, assign) float x;
@property (nonatomic, assign) float y;
@property (nonatomic, assign) int xdirection;
@property (nonatomic, assign) int ydirection;
@property (nonatomic, assign) float width;
@property (nonatomic, assign) float height;

- (void) draw;
- (Sprite *) init;
@end
