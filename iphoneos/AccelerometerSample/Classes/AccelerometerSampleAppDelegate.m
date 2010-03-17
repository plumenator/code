//
//  AccelerometerSampleAppDelegate.m
//  AccelerometerSample
//
//  Created by Karthik Ravikanti on 24/02/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "AccelerometerSampleAppDelegate.h"
#import "EAGLView.h"

@implementation AccelerometerSampleAppDelegate

@synthesize window;
@synthesize glView;

- (void) applicationDidFinishLaunching:(UIApplication *)application
{
	[glView startAnimation];
}

- (void) applicationWillResignActive:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) applicationDidBecomeActive:(UIApplication *)application
{
	[glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	[glView stopAnimation];
}

- (void) dealloc
{
	[window release];
	[glView release];
	
	[super dealloc];
}

@end
