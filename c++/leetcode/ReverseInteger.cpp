// Reverse digits of an integer.

// Example1: x = 123, return 321
// Example2: x = -123, return -321

#include <iostream>
#include <vector>
#include <map>
#include <limits>
#include <algorithm>

int reverse(int x) {
  int sign {x >= 0 ? 1 : -1};
  int y {0};

  x = sign * x;
  while (x > 0) {
    if (y > std::numeric_limits<int>::max() / 10)
      return 0;
    
    y = (y * 10) + x % 10;
    x = x / 10;
  }

  return sign * y;
}

int main() {
  int x {0};

  std::cin >> x;
  
  std::cout << reverse(x) << std::endl;
  
  return 0;
}
