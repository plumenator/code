//
//  Pane.m
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "Pane.h"


@implementation Pane

@synthesize symbol, turn, won, noMove;

- (id)initWithFrame:(CGRect)frame withSymbol:(int)newSymbol {
    if (self = [super initWithFrame:frame]) {
		self.symbol = newSymbol;
		self.turn = newSymbol == 1 ? YES : NO;
		self.won = 0;
		CGRectDivide([self bounds], &symbolRect, &messageRect, 
					 [self bounds].size.width/3, CGRectMinXEdge);
		CGRectDivide(messageRect, &messageRect, &smileyRect, 
					 messageRect.size.width/2, CGRectMinXEdge);
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
	CGContextRef context = UIGraphicsGetCurrentContext();
	[[UIColor whiteColor] set];
	CGContextBeginPath(context);
	CGContextSetLineWidth(context, 5);
	
    if (CGRectEqualToRect(rect, [self bounds])) {
		[self drawSymbolInContext:context];
		[self drawMessageInContext:context];
		[self drawSmileyInConext:context];
	}
	
	CGContextStrokePath(context);
}


- (void) drawSymbolInContext:(CGContextRef)context {
	int delta = 20;
	CGContextAddRect(context, symbolRect);
	CGContextMoveToPoint(context, 
						 symbolRect.origin.x + delta, symbolRect.origin.y + delta);
		if (self.symbol == 1) {
			// Draw a cross.
			CGContextAddLineToPoint(context, 
									symbolRect.origin.x + symbolRect.size.width - delta, 
									symbolRect.origin.y + symbolRect.size.height - delta);
			CGContextMoveToPoint(context, symbolRect.origin.x + delta, 
								 symbolRect.origin.y + symbolRect.size.height - delta);
			CGContextAddLineToPoint(context, 
									symbolRect.origin.x + symbolRect.size.width - delta,
									symbolRect.origin.y + delta);
		} else if (self.symbol == 2) {
			// Draw a circle.
			CGContextAddEllipseInRect(context, CGRectInset(symbolRect,delta,delta));
			
		} else {
			NSLog(@"Unkown symbol code: %d",self.symbol);
		}
}


- (void) drawMessageInContext:(CGContextRef)context {
	CGContextAddRect(context, messageRect);
	if (self.won == 1) {
		UIFont *font = [UIFont systemFontOfSize:30];
		[@"Winner!" drawInRect:CGRectInset(messageRect, 10, 10) withFont:font];
		[font autorelease];
	} else if (self.won == -1) {
		UIFont *font = [UIFont systemFontOfSize:30];
		[@"Loser." drawInRect:CGRectInset(messageRect, 10, 10) withFont:font];
	} else if (self.turn) {
		UIFont *font = [UIFont systemFontOfSize:30];
		[@"Your turn." drawInRect:CGRectInset(messageRect, 10, 10) withFont:font];
	} else if (self.noMove) {
		UIFont *font = [UIFont systemFontOfSize:30];
		[@"It's a tie!" drawInRect:CGRectInset(messageRect, 10, 10) withFont:font];
	}
}


- (void) drawSmileyInConext:(CGContextRef)context {
	CGContextAddRect(context, smileyRect);
	int delta = 10;
	// Draw a circle.
	CGContextAddEllipseInRect(context, CGRectInset(smileyRect,delta,delta));
	
	// Draw two smaller circles for eyes.
	CGSize eyeSize = {smileyRect.size.width/8, smileyRect.size.height/8};
	
	CGRect leftEyeRect = {{smileyRect.size.width/3 + smileyRect.origin.x,
		smileyRect.size.height/4 + smileyRect.origin.y}, eyeSize};
	CGContextAddEllipseInRect(context, leftEyeRect);
	
	CGRect rightEyeRect = {{leftEyeRect.origin.x + 2*eyeSize.width,
		smileyRect.size.height/4 + smileyRect.origin.y}, eyeSize};
	CGContextAddEllipseInRect(context, rightEyeRect);	
	
	// Draw the smiley.
	CGContextMoveToPoint(context, smileyRect.origin.x + smileyRect.size.width/3,
						 smileyRect.origin.y + 2*smileyRect.size.height/3);
	if (won == 1) {
		CGContextAddArcToPoint(context, smileyRect.origin.x + smileyRect.size.width/2, 
							   smileyRect.origin.y + 5*smileyRect.size.height/6, 
							   smileyRect.origin.x + 2*smileyRect.size.width/3,
							   smileyRect.origin.y + 2*smileyRect.size.height/3, 
							   smileyRect.size.height/3);
	} else if (won == 0) {
		CGContextAddLineToPoint(context, smileyRect.origin.x + 2*smileyRect.size.width/3, 
								smileyRect.origin.y + 2*smileyRect.size.height/3);
	} else {
		CGContextMoveToPoint(context, smileyRect.origin.x + smileyRect.size.width/3,
							 smileyRect.origin.y + 2*smileyRect.size.height/3);		
		CGContextAddArcToPoint(context, smileyRect.origin.x + smileyRect.size.width/2, 
							   smileyRect.origin.y + smileyRect.size.height/2, 
							   smileyRect.origin.x + 2*smileyRect.size.width/3,
							   smileyRect.origin.y + 2*smileyRect.size.height/3, 
							   smileyRect.size.height/3);
	}

}

- (void)dealloc {
    [super dealloc];
}


@end
