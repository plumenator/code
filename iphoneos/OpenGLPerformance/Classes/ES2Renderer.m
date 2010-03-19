//
//  ES2Renderer.m
//  OpenGLPerformance
//
//  Created by Dhanesh Pai on 17/11/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ES2Renderer.h"
#import "DonutGL.h"
#import "RectangleGL.h"
#import "FilledCircleGL.h"
#import "CircleGL2.h"
#import "ImageGL2.h"
#import "Common.h"
#import "Sprite.h"

// uniform index
enum {
    UNIFORM_TRANSLATE,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// attribute index
enum {
    ATTRIB_VERTEX,
    ATTRIB_COLOR,
    NUM_ATTRIBUTES
};

@interface ES2Renderer (PrivateMethods)
- (BOOL) loadShaders;
- (BOOL) compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL) linkProgram:(GLuint)prog;
- (BOOL) validateProgram:(GLuint)prog;
@end

@implementation ES2Renderer

@synthesize frameCount;

// Create an ES 2.0 context
- (id) init
{
	if (self = [super init])
	{
		context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
        
        if (!context || ![EAGLContext setCurrentContext:context] || ![self loadShaders])
		{
            [self release];
            return nil;
        }
		
		// Create default framebuffer object. The backing will be allocated for the current layer in -resizeFromLayer
		glGenFramebuffers(1, &defaultFramebuffer);
		glGenRenderbuffers(1, &colorRenderbuffer);
		glBindFramebuffer(GL_FRAMEBUFFER, defaultFramebuffer);
		glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
		glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_RENDERBUFFER, colorRenderbuffer);
		srand(time(NULL));

		fpsTimer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(1.0) target:self selector:@selector(takeSample) userInfo:nil repeats:TRUE];
		self.frameCount = 0;
		
		switch (SpriteType)
		{
			case Circles:
				[CircleGL2 initCoeffs];
				for (int i =0; i < SPRITE_COUNT; ++i) 
				{
					sprites[i] = [[CircleGL2 alloc] initWithRadius:rand() % 50];
				}
				break;
				
			case Images:
				for (int i =0; i < SPRITE_COUNT; ++i) 
				{
					sprites[i] = [[ImageGL2 alloc] initWithImageNamed:@"Sprite.png"];
					sprites[i].width = rand() % 50;
					sprites[i].height = rand() % 100;
				}
				break;
				
			case ImagesWithAlpha:
				for (int i =0; i < SPRITE_COUNT; ++i) 
				{
					sprites[i] = [[ImageGL2 alloc] initWithImageNamed:@"SpriteWithAlpha.png" constantAlpha:.5];
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
    
    glClearColor(1.f, 1.f, 1.f, 1.f);
    glClear(GL_COLOR_BUFFER_BIT);
	
	float mvp[16] = 
	{
		2.f/200, 0, 0, 0, 
		0, 2.f*aspectRatio/200, 0, 0,
		0, 0, 2.f/.2f, 0,
		0, 0, 0, 1
	};
	
	GLfloat dx = 0, dy = 0;
	
	glUseProgram(program);
	glUniformMatrix4fv(glGetUniformLocation(program, "u_mvp_matrix"), 1, GL_FALSE, mvp);	
	
	for (int i =0; i < SPRITE_COUNT; ++i)
	{
		dx = sprites[i].xdirection*(5 - (rand() % 10));
		dy = sprites[i].ydirection*(5 - (rand() % 10));
		sprites[i].x = sprites[i].x + (abs(sprites[i].x+dx) > (100-sprites[i].width) ? sprites[i].xdirection = -sprites[i].xdirection,-dx : dx);
		sprites[i].y = sprites[i].y + (abs(sprites[i].y+dy) > (100/aspectRatio-sprites[i].height) ? sprites[i].ydirection = -sprites[i].ydirection,-dy : dy);
		GLfloat center[4] = {sprites[i].x,sprites[i].y,0,0};
		glUniform4fv(glGetUniformLocation(program, "u_translated"), 1, center);
		[sprites[i] draw];
	}
	
	[context presentRenderbuffer:GL_RENDERBUFFER];
}

- (BOOL) compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
	GLint status;
	const GLchar *source;
	
	source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
	if (!source)
	{
		NSLog(@"Failed to load vertex shader");
		return FALSE;
	}
	
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
	
#if defined(DEBUG)
	GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
	{
		glDeleteShader(*shader);
		return FALSE;
	}
	
	return TRUE;
}

- (BOOL) linkProgram:(GLuint)prog
{
	GLint status;
	
	glLinkProgram(prog);
	
#if defined(DEBUG)
	GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0)
		return FALSE;
	
	return TRUE;
}

- (BOOL) validateProgram:(GLuint)prog
{
	GLint logLength, status;
	
	glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0)
		return FALSE;
	
	return TRUE;
}

- (BOOL) loadShaders
{
    GLuint vertShader, fragShader;
	NSString *vertShaderPathname, *fragShaderPathname;
    
    // create shader program
    program = glCreateProgram();
	
    // create and compile vertex shader
	vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
	if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname])
	{
		NSLog(@"Failed to compile vertex shader");
		return FALSE;
	}
	
    // create and compile fragment shader
	fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
	if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname])
	{
		NSLog(@"Failed to compile fragment shader");
		return FALSE;
	}
    
    // attach vertex shader to program
    glAttachShader(program, vertShader);
    
    // attach fragment shader to program
    glAttachShader(program, fragShader);
    
    // link program
	if (![self linkProgram:program])
	{
		NSLog(@"Failed to link program: %d", program);
		return FALSE;
	}
    
    // get uniform locations
    uniforms[UNIFORM_TRANSLATE] = glGetUniformLocation(program, "translate");
    
    // release vertex and fragment shaders
    if (vertShader)
		glDeleteShader(vertShader);
    if (fragShader)
		glDeleteShader(fragShader);
	
	return TRUE;
}

- (BOOL) resizeFromLayer:(CAEAGLLayer *)layer
{
	// Allocate color buffer backing based on the current layer size
    glBindRenderbuffer(GL_RENDERBUFFER, colorRenderbuffer);
    [context renderbufferStorage:GL_RENDERBUFFER fromDrawable:layer];
	glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_WIDTH, &backingWidth);
    glGetRenderbufferParameteriv(GL_RENDERBUFFER, GL_RENDERBUFFER_HEIGHT, &backingHeight);
	
    if (glCheckFramebufferStatus(GL_FRAMEBUFFER) != GL_FRAMEBUFFER_COMPLETE)
	{
        NSLog(@"Failed to make complete framebuffer object %x", glCheckFramebufferStatus(GL_FRAMEBUFFER));
        return NO;
    }
	
    return YES;
}

- (void) dealloc
{
	// Tear down GL
	if (defaultFramebuffer)
	{
		glDeleteFramebuffers(1, &defaultFramebuffer);
		defaultFramebuffer = 0;
	}
	
	if (colorRenderbuffer)
	{
		glDeleteRenderbuffers(1, &colorRenderbuffer);
		colorRenderbuffer = 0;
	}
	
	if (program)
	{
		glDeleteProgram(program);
		program = 0;
	}
	
	// Tear down context
	if ([EAGLContext currentContext] == context)
        [EAGLContext setCurrentContext:nil];
	
	[context release];
	context = nil;
	
	[super dealloc];
}

@end
