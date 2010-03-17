//
//  iPadOpenGLExampleAppDelegate.m
//  iPadOpenGLExample
//
//  Created by Karthik Ravikanti on 09/02/10.
//  Copyright Apple Inc 2010. All rights reserved.
//

#import "iPadOpenGLExampleAppDelegate.h"
#import "EAGLView.h"

@implementation iPadOpenGLExampleAppDelegate

@synthesize window;
@synthesize glView;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [glView startAnimation];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [glView stopAnimation];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [glView startAnimation];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [glView stopAnimation];
}

- (void)dealloc
{
    [window release];
    [glView release];

    [super dealloc];
}

@end
