//
//  ES1Renderer.h
//  AccelerometerSample
//
//  Created by Karthik Ravikanti on 24/02/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "ESRenderer.h"

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ES1Renderer : NSObject <ESRenderer, UIAccelerometerDelegate>
{
@private
	EAGLContext *context;
	
	// The pixel dimensions of the CAEAGLLayer
	GLint backingWidth;
	GLint backingHeight;
	
	// The OpenGL names for the framebuffer and renderbuffer used to render to this view
	GLuint defaultFramebuffer, colorRenderbuffer;
	
	UIAccelerometer *accelerometer;
	
	float accelX, accelY, accelZ, kFilteringFactor, x, y, z;
}

- (void) render;
- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer;

@property (nonatomic, retain) UIAccelerometer *accelerometer;

@end
