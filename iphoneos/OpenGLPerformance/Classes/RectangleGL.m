//
//  RectangleGL.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "RectangleGL.h"


@implementation RectangleGL

@synthesize width, height;

- (RectangleGL *) initWithWidth:(GLfloat)new_width height:(GLfloat)new_height {
	self.width = new_width;
	self.height = new_height;
	return self;
}

- (void) draw {
	GLfloat vertices[] = {-self.width/2.0,self.height/2.0,self.width/2.0,self.height/2.0,self.width/2.0,-self.height/2.0,-self.width/2.0,-self.height/2.0};
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glDrawArrays(GL_LINE_LOOP, 0, 4);
}	
@end
