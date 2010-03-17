//
//  ImageGL.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 18/11/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "ImageGL.h"
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Common.h"

@implementation ImageGL


- (ImageGL *) initWithImageNamed:(NSString *)name constantAlpha:(float)alpha
{
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
		glGenTextures(1, &texture);
		glBindTexture(GL_TEXTURE_2D, texture);
		glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, pixelsWide, pixelsHigh, 0, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, texture);
		
	}
	return self;
}

- (ImageGL *) initWithImageNamed:(NSString *)name
{
	return [self initWithImageNamed:name constantAlpha:1];
}

- (void) draw
{
	
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
	glVertexPointer(2, GL_FLOAT, 0, spriteVertices);
	glEnableClientState(GL_VERTEX_ARRAY);
	glTexCoordPointer(2, GL_SHORT, 0, spriteTexcoords);
	glEnableClientState(GL_TEXTURE_COORD_ARRAY);
	
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	
	// Enable use of the texture
	glEnable(GL_TEXTURE_2D);
	
	if (SpriteType == ImagesWithAlpha) {
		// Set a blending function to use
		glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
		// Enable blending
		glEnable(GL_BLEND);
	}
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);
	
	glDisable(GL_TEXTURE_2D);
//	glDisable(GL_BLEND);
	glDisableClientState(GL_TEXTURE_COORD_ARRAY);
	glDisableClientState(GL_VERTEX_ARRAY);
}

- (void) dealloc
{
	glDeleteTextures(1, &texture);
	free(buffer);
	[super dealloc];
}

@end
