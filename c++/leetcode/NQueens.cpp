// The n-queens puzzle is the problem of placing n queens on an n×n chessboard such that no two queens attack each other.



// Given an integer n, return all distinct solutions to the n-queens puzzle.

// Each solution contains a distinct board configuration of the n-queens' placement, where 'Q' and '.' both indicate a queen and an empty space respectively.

// For example,
// There exist two distinct solutions to the 4-queens puzzle:

// [
//  [".Q..",  // Solution 1
//   "...Q",
//   "Q...",
//   "..Q."],

//  ["..Q.",  // Solution 2
//   "Q...",
//   "...Q",
//   ".Q.."]
// ]

#include <iostream>
#include <vector>
#include <set>
#include <utility>
#include <string>
#include <limits>
#include <algorithm>




bool placeQueen(std::vector<std::string>& board, unsigned row, unsigned col) {
  // Check row left
  for (unsigned i = 0; i < col; ++i) {
    if (board[row][i] == 'Q') {
      return false;
    }
  }

  // Check upper left diagonal
  for (int i = row - 1, j = col - 1; i >= 0 && j >= 0; --i, --j) {
    if (board[i][j] == 'Q') {
      return false;
    }
  }
  
  // Check lower left diagonal
  for (int i = row + 1, j = col - 1; i < (int)board.size() && j >= 0; ++i, --j) {
    if (board[i][j] == 'Q') {
      return false;
    }
  }

  return true;
}

void recurse(std::vector<std::string>& board, unsigned col, std::vector<std::vector<std::string>>& solutions) {
  if (col >= board.size()) {
    solutions.push_back(board);
    return;
  }

  for (unsigned row = 0; row < board.size(); ++row) {
    if (placeQueen(board, row, col)) {
      board[row][col] = 'Q';
      recurse(board, col + 1, solutions);
      board[row][col] = '.';
    }
  }
}

std::vector<std::vector<std::string>> solveNQueens(int n) {
  std::vector<std::vector<std::string>> solutions;
  std::vector<std::string> board;
  std::string s(n, '.');
  
  for (int i = 0; i < n; ++i) {
    board.push_back(s);
  }

  recurse(board, 0, solutions);

  return solutions;
}
int main() {
  int n {0};

  std::cin >> n;

  auto solutions = solveNQueens(n);
  
  for (unsigned i = 0; i < solutions.size(); ++i) {
    std::cout << "Solution " << i + 1 << ":" << std::endl;
    for (auto line : solutions[i]) {
      std::cout << line << std::endl;
    }
  }

  return 0;
}
