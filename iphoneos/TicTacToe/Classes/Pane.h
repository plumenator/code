//
//  Pane.h
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Pane : UIView {
	int symbol;
	CGRect smileyRect;
	CGRect messageRect;
	CGRect symbolRect;
	
@public
	BOOL turn;
	int won;
	BOOL noMove;
}

@property (nonatomic, assign) BOOL turn;
@property (nonatomic, assign) int symbol;
@property (nonatomic, assign) int won;
@property (nonatomic, assign) BOOL noMove;

- (id) initWithFrame:(CGRect)frame withSymbol:(int)newSymbol;
- (void) drawSymbolInContext:(CGContextRef)context;
- (void) drawMessageInContext:(CGContextRef)context;
- (void) drawSmileyInConext:(CGContextRef)context;
@end
