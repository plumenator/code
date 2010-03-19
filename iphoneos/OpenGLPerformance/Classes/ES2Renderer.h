//
//  ES2Renderer.h
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "Sprite.h"
#import "Common.h"

@interface ES2Renderer : NSObject <ESRenderer>
{
@private
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
	
	GLuint program;
	NSTimer *fpsTimer;

	float frameCount;
	Sprite *sprites[SPRITE_COUNT];
}

@property (assign, readwrite) float frameCount;

- (void) takeSample;
- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@end

