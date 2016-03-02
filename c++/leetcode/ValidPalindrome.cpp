// Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.

// For example,
// "A man, a plan, a canal: Panama" is a palindrome.
// "race a car" is not a palindrome.

// Note:
// Have you consider that the string might be empty? This is a good question to ask during an interview.

// For the purpose of this problem, we define empty string as valid palindrome. 

#include <string>
#include <iostream>

using namespace std;

bool alphanum(char ch) {
  return ((ch<='Z' && ch>='A') || (ch<='z' && ch>='a') || (ch<='9' && ch>='0'));
}

char easytolower(char ch) {
  if(ch<='Z' && ch>='A')
    return ch-('Z'-'z');
  return ch;
} 

bool isPalindrome(string s) {
  string t;
  
  for (auto i = s.begin(); i != s.end(); ++i) {
    if(alphanum(*i))
      t.push_back(easytolower(*i));
  }
  
  for (int i = 0, j = t.size() - 1; i < j; ++i, --j) {
    if (t[i] != t[j] ) {
      return false;
    }
  }
  
  return true;
}

int main() {
  std::string s;
  getline(cin, s);

  if (isPalindrome(s))
    cout << "YES";
  else
    cout << "NO";
}
