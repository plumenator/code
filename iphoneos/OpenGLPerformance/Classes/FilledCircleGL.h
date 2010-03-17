//
//  FilledCircleGL.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>


@interface FilledCircleGL : NSObject {
	
	GLfloat radius;
}

- (void) draw;
- (FilledCircleGL *) initWithRadiusF:(GLfloat)radius;
@property (nonatomic, assign) GLfloat radius;

@end
