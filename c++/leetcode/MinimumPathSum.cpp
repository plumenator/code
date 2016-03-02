// Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right which minimizes the sum of all numbers along its path.

// Note: You can only move either down or right at any point in time.

#include <iostream>
#include <vector>
#include <limits>
#include <algorithm>

int recurse(std::vector<std::vector<int>>& grid, int row, int col) {
  int m = grid.size();
  int n = grid[0].size();

  if (row == m - 1 && col == n - 1) {
    return grid[m - 1][n - 1];
  }
  else if (row == m - 1) {
    return grid[row][col] + recurse(grid, row, col + 1);
  }
  else if (col == n - 1) {
    return grid[row][col] + recurse(grid, row + 1, col);
  }

  return grid[row][col] + std::min(recurse(grid, row, col + 1), recurse(grid, row + 1, col));
}

int minPathSum_recursive(std::vector<std::vector<int>>& grid) {
  return recurse(grid, 0, 0);
}

int minPathSum(std::vector<std::vector<int>>& grid) {
  std::vector<int> mins(grid[0].size(), std::numeric_limits<int>::max());

  mins[0] = 0;
  
  for (unsigned row = 0; row < grid.size(); ++row) {
    mins[0] = mins[0] + grid[row][0];
    for (unsigned col = 1; col < grid[0].size(); ++col) {
      mins[col] = std::min(mins[col], mins[col - 1]) + grid[row][col];
    }
  }

  return mins.back();
}

int main() {
  int m {0};
  int n {0};
  int k {0};

  std::cin >> m;
  std::cin >> n;
  std::vector<std::vector<int>> grid(m, std::vector<int>(n));
  
  for (int i = 0; i < m; ++i) {
    for (int j = 0; j < n; ++j) {
      std::cin >> k;
      grid[i][j] = k;
    }
  }

  std::cout << minPathSum(grid) << std::endl;
  
  return 0;
}
