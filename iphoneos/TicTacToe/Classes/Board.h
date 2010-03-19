//
//  Board.h
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#import "GameController.h"
#import "TicTacToeCell.h"

@interface Board : UIView {
	int size;
	GameController *gameController;
	NSURL *dragSound;
	NSURL *selectSound;
	NSURL *tieSound;
	NSURL *winSound;
	BOOL invertColors;
	AVAudioPlayer *audio;
@public
	id cells[3][3];
	BOOL gameOn;
	int currSymbol;
}

@property (nonatomic, assign) int size;
@property (nonatomic, assign) int currSymbol;
@property (nonatomic, assign) BOOL gameOn;
@property (nonatomic, retain) GameController *gameController;
@property (nonatomic, retain) NSURL *dragSound;
@property (nonatomic, retain) NSURL *selectSound;
@property (nonatomic, retain) NSURL *tieSound;
@property (nonatomic, retain) NSURL *winSound;
@property (nonatomic, assign) BOOL invertColors;
@property (nonatomic, retain) AVAudioPlayer *audio;
//@property (nonatomic, retain) NSMutableArray *cells;

- (Board*) initWithFrame:(CGRect)frame size:(int)newSize gameController:controller;
- (void) drawGridWithSize:(int)gridSize;
- (void) initCells;
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void) resetCellWithPoint:(CGPoint *)point;
- (void) reDrawCell:(TicTacToeCell *)cell;
- (void) reDrawCellWithFill:(TicTacToeCell *)cell;
- (void) setNeedsDisplayInRect:(CGRect)rect invertColors:(BOOL)invertColors;

@end
