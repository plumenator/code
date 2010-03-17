//
//  ImageGL2.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "Sprite.h"

@interface ImageGL2 : Sprite {
	GLubyte *buffer;
	GLfloat pixelsHigh;
	GLfloat pixelsWide;
}

- (ImageGL2 *) initWithImageNamed:(NSString *)path;
- (ImageGL2 *) initWithImageNamed:(NSString *)path constantAlpha:(float)alpha;
- (void) draw;

@end
