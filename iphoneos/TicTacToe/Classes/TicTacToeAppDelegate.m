//
//  TicTacToeAppDelegate.m
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "TicTacToeAppDelegate.h"
#import "Pane.h"
#import "Board.h"
#import <CoreGraphics/CoreGraphics.h>

#define BOARD_PERCENTAGE 60

@implementation TicTacToeAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

	// Compute the dimensions.
	CGFloat totalWidth = [window bounds].size.width;
	CGFloat totalHeight = [window bounds].size.height;
	CGFloat boardHeight = (BOARD_PERCENTAGE/100.0) * totalHeight;
	CGFloat paneHeight = (totalHeight - boardHeight)/2;

	// Setup the top frame.
	CGRect topFrame = CGRectMake(0, 0, totalWidth, paneHeight);
	Pane *pane1 = [[Pane alloc] initWithFrame:topFrame withSymbol:1];
	pane1.backgroundColor = [UIColor redColor];
	[window addSubview:pane1];
	[pane1 release];
	
	// Setup the bottom frame.
	CGRect botFrame = CGRectMake(0, totalHeight-paneHeight, totalWidth, paneHeight);
	Pane *pane2 = [[Pane alloc] initWithFrame:botFrame withSymbol:2];
	pane2.backgroundColor = [UIColor redColor];
	[window addSubview:pane2];
	[pane2 release];
	
	// Setup the game controller
	GameController *controller = [[GameController alloc] initWithPane1:pane1
																 pane2:pane2];
	[controller autorelease];
	
	// Setup the middle frame.
	CGRect midFrame = CGRectMake(0, paneHeight, totalWidth, boardHeight);
	Board *board = [[Board alloc] initWithFrame:midFrame size:3 gameController:controller];
	[window addSubview:board];
	[board release];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
