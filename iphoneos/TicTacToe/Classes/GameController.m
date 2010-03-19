//
//  GameController.m
//  TicTacToe
//
//  Created by Karthik Ravikanti on 11/6/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "GameController.h"
#import "Board.h"
#import "TicTacToeCell.h"
#import <AVFoundation/AVFoundation.h>

@implementation GameController

@synthesize player1, player2, gameEnded, winner;

- (GameController *) initWithPane1:(Pane *)pane1 pane2:(Pane *)pane2 {
	self.player1 = pane1;
	self.player2 = pane2;
	self.winner = 0;
	self.gameEnded = NO;
	return self;
}

- (void) processMove:(Board *)board {
	// Change turns.
	if (board.currSymbol == 1) {
		self.player1.turn = YES;
		self.player2.turn = NO;
	} else {
		self.player1.turn = NO;
		self.player2.turn = YES;
	}
	
	[self examineBoard:board];
	// Find the winner if any.
	if (self.winner == 1) {
		self.player1.won = 1;
		self.player2.won = -1;
	} else if (self.winner == 2) {
		self.player1.won = -1;
		self.player2.won = 1;
	}
	
	// Terminate the game if a winner is found.
	if (self.gameEnded) {
		board.gameOn = NO;
		self.player1.turn = NO;
		self.player2.turn = NO;
		if (self.winner) {
			[board.audio initWithContentsOfURL:board.winSound
										  error:nil];
			[board.audio performSelector:@selector(play) withObject:nil afterDelay:0.1];
			
		} else {
			[board.audio initWithContentsOfURL:board.tieSound
										  error:nil];
			[board.audio performSelector:@selector(play) withObject:nil afterDelay:0.1];
		}

	}
	
	// Update the display.
	[self.player1 setNeedsDisplay];
	[self.player2 setNeedsDisplay];
}

- (void) examineBoard:(Board *)board {
	int i;
	
	// Check the rows.
	for (i=0; i<board.size; ++i) {
		TicTacToeCell *cell1 = (TicTacToeCell *) board->cells[i][0];
		TicTacToeCell *cell2 = (TicTacToeCell *) board->cells[i][1];
		TicTacToeCell *cell3 = (TicTacToeCell *) board->cells[i][2];
		if (cell1.state == cell2.state && cell2.state == cell3.state && cell1.state) {
			self.winner = cell1.state;
			self.gameEnded = YES;
			[self fillCell:cell1 onBoard:board];
			[self fillCell:cell2 onBoard:board];
			[self fillCell:cell3 onBoard:board];			
			return;
		}
	}
	
	// Check the colums.
	for (i=0; i<board.size; ++i) {
		TicTacToeCell *cell1 = (TicTacToeCell *) board->cells[0][i];
		TicTacToeCell *cell2 = (TicTacToeCell *) board->cells[1][i];
		TicTacToeCell *cell3 = (TicTacToeCell *) board->cells[2][i];
		if (cell1.state == cell2.state && cell2.state == cell3.state && cell1.state) {
			self.winner = cell1.state;
			self.gameEnded = YES;
			[self fillCell:cell1 onBoard:board];
			[self fillCell:cell2 onBoard:board];
			[self fillCell:cell3 onBoard:board];			
			return;
		}
	}	
	
	// Check the left-right diagonal
	TicTacToeCell *cell1 = (TicTacToeCell *) board->cells[0][0];
	TicTacToeCell *cell2 = (TicTacToeCell *) board->cells[1][1];
	TicTacToeCell *cell3 = (TicTacToeCell *) board->cells[2][2];
	if (cell1.state == cell2.state && cell2.state == cell3.state && cell1.state) {
		self.winner = cell1.state;
		self.gameEnded = YES;
		[self fillCell:cell1 onBoard:board];
		[self fillCell:cell2 onBoard:board];
		[self fillCell:cell3 onBoard:board];		
		return;
	}
	
	// Check the right-left diagonal
	cell1 = (TicTacToeCell *) board->cells[2][0];
	cell2 = (TicTacToeCell *) board->cells[1][1];
	cell3 = (TicTacToeCell *) board->cells[0][2];
	if (cell1.state == cell2.state && cell2.state == cell3.state && cell1.state) {
		self.winner = cell1.state;
		self.gameEnded = YES;
		[self fillCell:cell1 onBoard:board];
		[self fillCell:cell2 onBoard:board];
		[self fillCell:cell3 onBoard:board];
		return;
	}
	
	int j;
	// Check if the board is full.
	for (i=0; i<board.size; ++i) {
		for (j=0; j<board.size; ++j) {
			TicTacToeCell *cell = (TicTacToeCell *) board->cells[i][j];
			if (cell.state > 0) {
				return;
			}
		}
	}	
	
	self.winner = 0;
	self.player1.noMove = YES;
	self.player2.noMove = YES;
	self.gameEnded = YES;
}

- (void) fillCell:(TicTacToeCell *)cell onBoard:(Board *)board {
	[board performSelector:@selector(reDrawCellWithFill:)
				withObject:cell
				afterDelay:0.1];
}

@end
