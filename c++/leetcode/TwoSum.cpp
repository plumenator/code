// Given an array of integers, find two numbers such that they add up to a specific target number.

// The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2. Please note that your returned answers (both index1 and index2) are not zero-based.

// You may assume that each input would have exactly one solution.

// Input: numbers={2, 7, 11, 15}, target=9
// Output: index1=1, index2=2

#include <iostream>
#include <vector>
#include <map>
#include <limits>
#include <algorithm>

std::vector<int> twoSum(std::vector<int>& nums, int target) {
  std::map<int, int> indices;

  for (int i = 0; i < (int)nums.size(); ++i) {
    auto search = indices.find(target - nums[i]);
    if (search != indices.end()) {
      return {std::min(i + 1, search->second), std::max(i + 1, search->second)};
    }
    else if (indices.find(nums[i]) == indices.end()) {
      indices[nums[i]] = i + 1;
    }
  }

  return {0, 0};
}

int main() {
  int target {0};
  std::vector<int> nums;
  int i {0};

  std::cin >> target;
  
  while(std::cin >> i) {
    nums.push_back(i);
  }

  std::vector<int> pair = twoSum(nums, target);
  
  std::cout << pair[0] << ", " << pair[1] << std::endl;
  
  return 0;
}
