//
//  RectangleGL.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface RectangleGL : NSObject {
	GLfloat width;
	GLfloat height;
}

@property (nonatomic, assign) GLfloat width;
@property (nonatomic, assign) GLfloat height;

- (RectangleGL *) initWithWidth:(GLfloat)width height:(GLfloat)height;
- (void) draw;
@end
