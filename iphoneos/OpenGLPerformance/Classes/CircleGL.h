//
//  CircleGL.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Sprite.h"

@interface CircleGL : Sprite {
	GLfloat radius;
}

- (void) draw;
- (CircleGL *) initWithRadius:(GLfloat)radius;
+ (void) initCoeffs;

@property (nonatomic, assign) GLfloat radius;
@end
