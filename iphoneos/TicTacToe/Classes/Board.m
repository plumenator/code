//
//  Board.m
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Board.h"
#import <CoreGraphics/CoreGraphics.h>
#import "TicTacToeCell.h"
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>

@implementation Board

@synthesize size, currSymbol, gameOn, gameController, dragSound, selectSound, tieSound,
winSound, invertColors, audio;//, cells;

- (id)initWithFrame:(CGRect)frame size:(int)newSize gameController:(GameController *)controller {
    if (self = [super initWithFrame:frame]) {
		self.size = newSize;
		[self initCells];
		self.gameOn = YES;
		self.currSymbol = 1;
		self.gameController = controller;
		self.dragSound = [[NSURL alloc] 
						  initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"drag" 
																			  ofType:@"au"]];
		self.selectSound = [[NSURL alloc] 
							initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"select" 
																				ofType:@"au"]];
		self.tieSound = [[NSURL alloc]
						 initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"tie" 
																			 ofType:@"au"]];
		self.winSound = [[NSURL alloc]
						 initFileURLWithPath:[[NSBundle mainBundle] pathForResource:@"win" 
																			 ofType:@"au"]];
		self.audio = [AVAudioPlayer alloc];

		self.backgroundColor = [UIColor blackColor];
		self.invertColors = NO;
	}
	return self;
}


- (void)drawRect:(CGRect)rect {
	if (rect.origin.x == [self bounds].origin.x
		&& rect.origin.y == [self bounds].origin.y
		&& rect.size.width == [self bounds].size.width
		&& rect.size.height == [self bounds].size.height) {
		[self drawGridWithSize: self.size];
	} else {
		int i,j;
		for (i=0; i<self.size; ++i) {
			for (j=0; j<self.size; ++j) {
				TicTacToeCell *cell = (TicTacToeCell *) cells[i][j];
				if (CGRectContainsRect(cell.rect,CGRectInset(rect,10,10))) {
					CGContextRef context = UIGraphicsGetCurrentContext();					
					[[UIColor whiteColor] set];
					CGContextSetLineWidth(context, 5);
					[cell drawInContext:context invertColors:self.invertColors];
					self.invertColors = NO;
					CGContextStrokePath(context);
					return;
				}
			}
		}
	}
	
}

- (void)drawGridWithSize:(int)gridSize {
	
	CGFloat width = [self bounds].size.width;
	CGFloat height = [self bounds].size.height;
	
	[[UIColor whiteColor] set];
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextBeginPath(context);
	CGContextSetLineWidth(context, 5);
	
	int i = 0;
	for (i=1; i<gridSize; ++i) {
		// Draw box
		CGRect box = {{0,0},{width,height}};
		CGContextAddRect(context, box);
		// Draw vertical lines.
		CGContextMoveToPoint(context, i*width/gridSize, 0);
		CGContextAddLineToPoint(context, i*width/gridSize, height);
		
		// Draw horizontal lines.	
		CGContextMoveToPoint(context, 0, i*height/gridSize);
		CGContextAddLineToPoint(context, width, i*height/gridSize);
	}
	
	// Draw all cells.
	int j = 0;
	for (i=0; i<gridSize; ++i) {
		for (j=0; j<gridSize; ++j) {
			TicTacToeCell *cell = (TicTacToeCell *) cells[i][j];
			if (cell != nil) {
				[cell drawInContext:context];
			} else {
				NSLog(@"Cell not found at index %d",i);
			}
		}
	}
	
	CGContextStrokePath(context);
}

- (void) initCells {
	CGFloat width = [self bounds].size.width;
	CGFloat height = [self bounds].size.height;
	
	int i =0, j=0;
	CGRect rect = {{0,0},{0,0}};
	for (i=0; i<self.size; ++i) {
		rect.origin.x = i * width/self.size;
		for (j=0; j<self.size; ++j) {
			rect.origin.y = j * height/self.size;
			rect.size.width = width/self.size;
			rect.size.height = height/self.size;
			TicTacToeCell *cell = [[TicTacToeCell alloc] initWithRect:&rect state:0];
			cells[i][j] = (id) cell;
		}
	}
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	int i,j;
	if (self.gameOn) {
		for (i=0; i<self.size; ++i) {
			for (j=0; j<self.size; ++j) {
				TicTacToeCell *cell = (TicTacToeCell *) cells[i][j];
				if (CGRectContainsPoint(cell.rect, [touch locationInView:self])) {
					NSLog(@"Tapped in (%d,%d)",i,j);
					if (cell.state == -1) {
						cell.state = self.currSymbol;
						self.currSymbol = self.currSymbol == 1 ? 2 : 1;
						[self setNeedsDisplayInRect:cell.rect];
						[self.audio initWithContentsOfURL:self.selectSound
													error:nil];
						[self.audio performSelector:@selector(play) 
										 withObject:audio 
										 afterDelay:0.1];						[audio performSelector:@selector(play) withObject:audio afterDelay:0.1];
						
						[self.gameController processMove:self];
					}
					return;
				}
			}
		}
	}
}

- (void)dealloc {
	[selectSound release];
	[dragSound release];
	[tieSound release];
	[winSound release];
	[audio release];
    [super dealloc];
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	int i,j;
	if (self.gameOn) {
		for (i=0; i<self.size; ++i) {
			for (j=0; j<self.size; ++j) {
				TicTacToeCell *cell = (TicTacToeCell *) cells[i][j];
				if (CGRectContainsPoint(cell.rect, [touch locationInView:self])) {
					NSLog(@"Touched in (%d,%d)",i,j);
					if (cell.state == 0) {
						cell.state = -1;
						[self setNeedsDisplayInRect:cell.rect];
					}
					return;
				}
			}
		}
	}
	
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [touches anyObject];
	CGPoint currPos = [touch locationInView:self];
	CGPoint prevPos = [touch previousLocationInView:self];
	
	int i,j;
	if (self.gameOn) {
		for (i=0; i<self.size; ++i) {
			for (j=0; j<self.size; ++j) {
				TicTacToeCell *cell = (TicTacToeCell *) cells[i][j];
				if (CGRectContainsPoint(cell.rect, currPos)
					&& !CGRectContainsPoint(cell.rect, prevPos)) {
					[self resetCellWithPoint:&prevPos];
					NSLog(@"Moved to (%d,%d)",i,j);
					if (cell.state == 0) {
						cell.state = -1;
						[self performSelector:@selector(reDrawCell:) 
								   withObject:cell
								   afterDelay:0.01];
						[self.audio initWithContentsOfURL:self.dragSound
													error:nil];
						[self.audio performSelector:@selector(play) 
										 withObject:nil
										 afterDelay:0.4];
					}
					return;
				}
			}
		}
	}
}

- (void) reDrawCell:(TicTacToeCell *)cell {
	[self setNeedsDisplayInRect:cell.rect];
}

- (void) reDrawCellWithFill:(TicTacToeCell *)cell {
	[self setNeedsDisplayInRect:cell.rect invertColors:YES];
}

- (void) setNeedsDisplayInRect:(CGRect)rect invertColors:(BOOL)invertColors {
	self.invertColors = YES;
	[self setNeedsDisplayInRect:rect];
}

- (void) resetCellWithPoint:(CGPoint *)point {
	int k,l;
	CGPoint prevPos = *point;
	for (k=0; k<self.size; ++k) {
		for (l=0; l<self.size; ++l) {
			TicTacToeCell *cell = (TicTacToeCell *) cells[k][l];
			if (CGRectContainsPoint(cell.rect, prevPos)) {
				if (cell.state == -1) {
					cell.state = 0;
					[self setNeedsDisplayInRect:cell.rect];
				}
				return;
			}
		}
	}
}

@end
