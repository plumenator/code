//
//  ImageGL.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import "Sprite.h"

@interface ImageGL : Sprite {
	GLubyte *buffer;
	GLfloat pixelsHigh;
	GLfloat pixelsWide;
	GLuint texture;
}

- (ImageGL *) initWithImageNamed:(NSString *)path;
- (ImageGL *) initWithImageNamed:(NSString *)name constantAlpha:(float)alpha;
- (void) draw;

@end
