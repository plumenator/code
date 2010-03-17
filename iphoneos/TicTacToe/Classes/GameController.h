//
//  GameController.h
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Pane.h"
#import "TicTacToeCell.h"

@class Board;

@interface GameController : NSObject {
	Pane *player1;
	Pane *player2;
	BOOL gameEnded;
	int winner;
}

@property (nonatomic, retain) Pane *player1;
@property (nonatomic, retain) Pane *player2;
@property (nonatomic, assign) BOOL gameEnded;
@property (nonatomic, assign) int winner;

- (GameController *) initWithPane1:(Pane *)pane1 pane2:(Pane *)pane2;
- (void) processMove:(Board *)board;
- (void) examineBoard:(Board *)board;
- (void) fillCell:(TicTacToeCell *)cell onBoard:(Board *)board;
@end
