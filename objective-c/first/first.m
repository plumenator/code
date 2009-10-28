#include <stdio.h>

/* 
 * The next #include line is generally present in all Objective-C
 * source files that use GNUstep.  The Foundation.h header file
 * includes all the other standard header files you need.
 */
#import <Foundation/Foundation.h>  // #import ensures a file is
				   // included only once. It is to be
				   // used only with Objective-C headers.

/*
 * Declare the Test class that implements the class method (classStringValue).
 */
@interface Test
+ (const char *) classStringValue;
@end

/*
 * Define the Test class and the class method (classStringValue).
 */
@implementation Test
+ (const char *) classStringValue;
{
  return "This is the string value of the Test class";
}
@end

/*
 * The main() function: pass a message to the Test class
 * and print the returned string.
 */
int main(void)
{
  printf("%s\n", [Test classStringValue]);
  
  /* Objects are of the type id */
  id obj = nil;			// The nil keyword MUST
				// be used to declare
				// non existent
				// objects.

  // We can test for the existence of an object before
  // sending a message.
  if (obj == nil) {
    printf("obj is nil\n");
  } else {
    printf("obj is non nil\n");
  }

  return 0;
}
