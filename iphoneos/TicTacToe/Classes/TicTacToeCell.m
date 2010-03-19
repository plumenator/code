//
//  TicTacToeCell.m
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "TicTacToeCell.h"


@implementation TicTacToeCell

@synthesize rect, state;

- (TicTacToeCell*) initWithRect:(CGRect *)newRect state:(NSInteger)newState {
	self.rect = *newRect;
	self.state = newState;
	return self;
}

- (BOOL) equals:(TicTacToeCell*)other {
	if (rect.origin.x == other.rect.origin.x
		&& rect.origin.y == other.rect.origin.y
		&& rect.size.width == other.rect.size.width
		&& rect.size.height == other.rect.size.height
		&& state == other.state) {
		return YES;
	} else {
		return NO;
	}
}

- (void) drawCrossInContext:(CGContextRef)context {
	int delta = 20;
	CGContextMoveToPoint(context, 
						 self.rect.origin.x + delta, self.rect.origin.y + delta);
	CGContextAddLineToPoint(context, 
							self.rect.origin.x + self.rect.size.width - delta, 
							self.rect.origin.y + self.rect.size.height - delta);
	CGContextMoveToPoint(context, self.rect.origin.x + delta, 
						 self.rect.origin.y + self.rect.size.height - delta);
	CGContextAddLineToPoint(context, 
							self.rect.origin.x + self.rect.size.width - delta,
							self.rect.origin.y + delta);
}

- (void) drawInContext:(CGContextRef) context invertColors:(BOOL)invertColors{
	int delta = 20;
	CGContextSetRGBFillColor(context,1.0,1.0,1.0,1.0);

	if (invertColors) {
		CGContextFillRect(context, self.rect);
		CGContextSetRGBStrokeColor(context, 0, 0, 0, 1);
	}
	
	CGContextAddRect(context, self.rect);
	CGContextMoveToPoint(context, 
						 self.rect.origin.x + delta, self.rect.origin.y + delta);
	
	if (self.state == 1) {
		[self drawCrossInContext:context];
	} else if (self.state == 2) {
		// Draw a circle.
		CGContextAddEllipseInRect(context, CGRectInset(self.rect,delta,delta));
		
	} else if (self.state == -1) {
		NSLog(@"Filing");
		CGContextFillRect(context, self.rect);
	} else if (self.state != 0) {
		NSLog(@"Unknown cell state: %d",self.state);
	}
}

- (void) drawInContext:(CGContextRef)context {
	[self drawInContext:context invertColors:NO];
}

@end
