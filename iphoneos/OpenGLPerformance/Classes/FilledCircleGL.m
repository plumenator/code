//
//  FilledCircleGL.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "FilledCircleGL.h"


#define TOTAL 50
@implementation FilledCircleGL

@synthesize radius;

- (FilledCircleGL *) initWithRadiusF:(GLfloat)new_radius {
	self.radius = new_radius;
	return self;
}

- (void) draw {
	GLfloat vertices[2*TOTAL];
	int i =0;
	vertices[i] = 0;
	vertices[i+1] = 1;
	for (i = 2; i < 2*TOTAL-2; i+=2) {
		vertices[i] = self.radius*cosf(3.14f/(TOTAL)*i);
		vertices[i+1] = self.radius*sinf(3.14f/(TOTAL)*i);
	}
	vertices[i] = self.radius*cosf(3.14f/(TOTAL)*i);
	vertices[i+1] = self.radius*sinf(3.14f/(TOTAL)*i);
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glDrawArrays(GL_TRIANGLE_FAN, 0, TOTAL);
}

@end
