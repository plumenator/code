//
//  DonutGL.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface DonutGL : NSObject {

	GLfloat inner_radius;
	GLfloat outer_radius;
}

@property (nonatomic, assign) GLfloat inner_radius;
@property (nonatomic, assign) GLfloat outer_radius;

+ (void) initCoeffs;
- (void)draw;
- (DonutGL *)initWithInnerRadius:(GLfloat)inner thickness:(GLfloat)outer;

@end
