//
//  ImageGL2.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGL2.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation ImageGL2

- (ImageGL2 *) initWithImageNamed:(NSString *)name constantAlpha:(float)alpha {
	if ([super init])
	{
		CGImageRef image = [UIImage imageNamed:name].CGImage;
		pixelsWide = CGImageGetWidth(image);
		pixelsHigh = CGImageGetHeight(image);
		self.x = self.y = 0;
		buffer = (GLubyte *) malloc(pixelsWide*pixelsHigh*4);
		CGContextRef context = CGBitmapContextCreate(buffer, pixelsWide, pixelsHigh, 8, pixelsWide*4, CGImageGetColorSpace(image), kCGImageAlphaPremultipliedLast);
		CGContextClearRect(context, CGRectMake(0, 0, pixelsWide, pixelsWide));
		CGContextDrawImage(context, CGRectMake(0, 0, pixelsWide, pixelsHigh), image);
		CGContextRelease(context);
		
		for (int i =0; i<pixelsWide*pixelsHigh*4; ++i) 
		{
			buffer[i] = buffer[i]*(alpha);
		}
	}
	return self;
}

- (ImageGL2 *) initWithImageNamed:(NSString *)name 
{
	return [self initWithImageNamed:name constantAlpha:1];
}

- (void) draw {
	// Sets up an array of values to use as the sprite vertices.
	const GLfloat spriteVertices[] = 
	{
		-self.width, -self.height,
		self.width, -self.height,
		-self.width,  self.height,
		self.width,  self.height,
	};
	
	// Sets up an array of values for the texture coordinates.
	const GLshort spriteTexcoords[] = 
	{
		0, 0,
		1, 0,
		0, -1,
		1, -1,
	};
	
	// Sets up pointers and enables states needed for using vertex arrays and textures
	glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, spriteVertices);
	glEnableVertexAttribArray(0);
	glVertexAttribPointer(1, 2, GL_SHORT, GL_FALSE, 0, spriteTexcoords);
	glEnableVertexAttribArray(1);
	
	GLuint texture;
	glGenTextures(1, &texture);
	glBindTexture(GL_TEXTURE_2D, texture);	
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, pixelsWide, pixelsHigh, 0, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
	glTexParameteri (GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	
	glEnable(GL_TEXTURE_2D);
	glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	glDisable(GL_TEXTURE_2D);
	glDisable(GL_BLEND);
	glDeleteTextures(1, &texture);
	glDisableVertexAttribArray(0);
	glDisableVertexAttribArray(1);
}

- (void) dealloc
{
	free(buffer);
	[super dealloc];
}

@end