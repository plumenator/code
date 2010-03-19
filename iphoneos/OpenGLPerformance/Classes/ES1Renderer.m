//
//  ES1Renderer.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ES1Renderer.h"
#import "DonutGL.h"
#import "RectangleGL.h"
#import "FilledCircleGL.h"
#import "CircleGL.h"
#import "ImageGL.h"
#import "Common.h"

@implementation ES1Renderer

@synthesize frameCount;

// Create an ES 1.1 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES1];
        
        if (!context || ![EAGLContext setCurrentContext:context])
		{
            [self release];
            return nil;
        }
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffersOES(1, &defaultFramebuffer);
		glGenRenderbuffersOES(1, &colorRenderbuffer);
		glBindFramebufferOES(GL_FRAMEBUFFER_OES, defaultFramebuffer);
		glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
		glFramebufferRenderbufferOES(GL_FRAMEBUFFER_OES, GL_COLOR_ATTACHMENT0_OES, GL_RENDERBUFFER_OES, colorRenderbuffer);

		fpsTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0) target:self selector:@selector(takeSample) userInfo:nil repeats:TRUE];
		srand(time(NULL));
		self.frameCount = 0;
		
		switch (SpriteType)
		{
			case Circles:
				glColor4f(0, 0, 0, 1);
				[CircleGL initCoeffs];
				for (int i =0; i < SPRITE_COUNT; ++i) 
				{
					sprites[i] = [[CircleGL alloc] initWithRadius:rand() % 50];
				}
				break;
				
			case Images:
				for (int i =0; i < SPRITE_COUNT; ++i) 
				{
					sprites[i] = [[ImageGL alloc] initWithImageNamed:@"Sprite.png"];
					sprites[i].width = 50;
					sprites[i].height = 100;
				}
				break;
				
			case ImagesWithAlpha:
				for (int i =0; i < SPRITE_COUNT; ++i) 
				{
					sprites[i] = [[ImageGL alloc] initWithImageNamed:@"SpriteWithAlpha.png" constantAlpha:.5];
					sprites[i].width = rand() % 50;
					sprites[i].height = rand() % 100;
				}
				break;
				
		}
		
	}
	
	return self;
}


- (void) takeSample
{
	NSLog(@"Frame rate = %f",frameCount);
	self.frameCount = 0;
}



- (void) render
{
	self.frameCount++;
	
    glViewport(0, 0, backingWidth, backingHeight);
	GLfloat aspectRatio = (GLfloat)backingWidth/backingHeight;
	
    glMatrixMode(GL_PROJECTION);
	glLoadIdentity();
	if (aspectRatio <= 1)
	{
		glOrthof(-100, 100, -100/aspectRatio, 100/aspectRatio, .1, -.1);
	}
	else
	{
		glOrthof(-100*aspectRatio, 100*aspectRatio, -100, 100, .1, -.1);
	}	
	
	
	GLfloat dx=0,dy=0;
	
	glClearColor(1.0f, 1.0f, 1.0f, 1.0f);
	glClear(GL_COLOR_BUFFER_BIT);
	glMatrixMode(GL_MODELVIEW);
	
	for (int i =0; i < SPRITE_COUNT; ++i)
	{
		dx = sprites[i].xdirection*(5 - (rand() % 10));
		dy = sprites[i].ydirection*(5 - (rand() % 10));
		sprites[i].x = sprites[i].x + (abs(sprites[i].x+dx) > (100-sprites[i].width/2) ? sprites[i].xdirection = -sprites[i].xdirection,-dx : dx);
		sprites[i].y = sprites[i].y + (abs(sprites[i].y+dy) > (100/aspectRatio-sprites[i].height/2) ? sprites[i].ydirection = -sprites[i].ydirection,-dy : dy);		
		glLoadIdentity();
		glTranslatef(sprites[i].x, sprites[i].y, 0);
		[sprites[i] draw];
	}
		
    [context presentRenderbuffer:GL_RENDERBUFFER_OES];
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{	
	// Allocate color buffer backing based on the current layer size
    glBindRenderbufferOES(GL_RENDERBUFFER_OES, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER_OES fromDrawable:layer];
	glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_WIDTH_OES, &backingWidth);
    glGetRenderbufferParameterivOES(GL_RENDERBUFFER_OES, GL_RENDERBUFFER_HEIGHT_OES, &backingHeight);
	
    if (glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES) != GL_FRAMEBUFFER_COMPLETE_OES)
	{
		NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatusOES(GL_FRAMEBUFFER_OES));
        return NO;
    }
    
    return YES;
}

- (void) dealloc
{
	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffersOES(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}
	
	if (colorRenderbuffer)
	{
		glDeleteRenderbuffersOES(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}


@end
