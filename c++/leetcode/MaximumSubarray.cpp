// Find the contiguous subarray within an array (containing at least one number) which has the largest sum.

// For example, given the array [−2,1,−3,4,−1,2,1,−5,4],
// the contiguous subarray [4,−1,2,1] has the largest sum = 6.

// More practice:
// If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

#include <iostream>
#include <vector>
#include <limits>
#include <algorithm>

int maxSubArray(std::vector<int>& nums) {
  int curr_sum = nums.at(0);
  int curr_max = nums.at(0);
  
  for (auto i = nums.begin() + 1; i != nums.end(); ++i) {
    curr_sum = std::max(*i, *i + curr_sum);
    curr_max = std::max(curr_sum, curr_max);
  }

  return curr_max;
}

int maxSubArray_kadane(std::vector<int>& nums) {
  int curr_sum = nums.at(0);
  int curr_max = nums.at(0);
  
  for (auto i = nums.begin() + 1; i != nums.end(); ++i) {
    curr_sum = std::max(*i, *i + curr_sum);
    curr_max = std::max(curr_sum, curr_max);
  }

  return curr_max;
}

int main() {
  std::vector<int> nums;
  int i {0};
  
  while(std::cin >> i) {
    nums.push_back(i);
  }
  std::cout << maxSubArray(nums) << std::endl;
  
  return 0;
}
