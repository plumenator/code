//
//  CircleGL.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "CircleGL.h"


#define TOTAL 50
@implementation CircleGL

@synthesize radius;

static GLfloat coeffs[4*TOTAL];

+ (void) initCoeffs
{
	
	static BOOL initialized = NO;
	if (!initialized)
	{
		for (int i = 0; i < 2*TOTAL; i+=2)
		{
			coeffs[i] = cosf(3.14f/TOTAL*i);
			coeffs[i+1] = sinf(3.14f/TOTAL*i);
		}
		initialized = YES;
	}
}

- (CircleGL *) initWithRadius:(GLfloat)new_radius
{
	if ([super init])
	{
		self.radius = new_radius;
		width = 2 * new_radius;
		height = 2 * new_radius;
	}
	return self;
}

- (void) draw
{
	GLfloat vertices[2*TOTAL];
	for (int i = 0; i < 2*TOTAL; i+=2)
	{
		vertices[i] = self.radius*coeffs[i];
		vertices[i+1] = self.radius*coeffs[i+1];
	}
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glDrawArrays(GL_LINE_LOOP, 0, TOTAL);
}

@end
