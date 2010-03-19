//
//  DonutGL.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "DonutGL.h"
#define TOTAL 50

@implementation DonutGL

@synthesize inner_radius, outer_radius;

static GLfloat coeffs[4*TOTAL];

+ (void) initCoeffs {

	static BOOL initialized = NO;
	if (!initialized)
	{
		for (int i = 0; i < 4*TOTAL; i+=4) {
			coeffs[i] = cosf(3.14f/TOTAL*i/2);
			coeffs[i+1] = sinf(3.14f/TOTAL*i/2);
			coeffs[i+2] = cosf(3.14f/TOTAL*i/2);
			coeffs[i+3] = sinf(3.14f/TOTAL*i/2);
		}
		initialized = YES;
	}
}

- (DonutGL *)initWithInnerRadius:(GLfloat)inner thickness:(GLfloat)thick {
	self.inner_radius = inner;
	self.outer_radius = inner + thick;
	[[self class] initCoeffs];
	return self;
}

- (void) draw {

	GLfloat vertices[4*TOTAL+4];
	int i;
	for (i = 0; i < 4*TOTAL; i+=4) {
		vertices[i] = self.inner_radius*coeffs[i];
		vertices[i+1] = self.inner_radius*coeffs[i+1];
		vertices[i+2] = self.outer_radius*coeffs[i+2];
		vertices[i+3] = self.outer_radius*coeffs[i+3];
	}
	vertices[i] = self.inner_radius;
	vertices[i+1] = 0;
	vertices[i+2] = self.outer_radius;
	vertices[i+3] = 0;
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 2*TOTAL+2);
}
	
@end
