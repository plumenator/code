//
//  TicTacToeCell.h
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface TicTacToeCell : NSObject {
	CGRect rect;
	NSInteger state;	
}

@property (nonatomic, assign) CGRect rect;
@property (nonatomic, assign) NSInteger state;

- (TicTacToeCell*) initWithRect:(CGRect*)rect state:(NSInteger)state;
- (BOOL) equals:(TicTacToeCell*) other;
- (void) drawInContext:(CGContextRef)context;
- (void) drawCrossInContext:(CGContextRef)context;
- (void) drawInContext:(CGContextRef)context invertColors:(BOOL)invertColors;
@end
