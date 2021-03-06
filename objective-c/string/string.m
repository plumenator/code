#include <stdio.h>
#import <Foundation/Foundation.h>

int main() {

  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  // Creating static NSString instances.
  NSString *w = @"Brainstorm";
  printf("Printing a statically created string: %s.\n",
	 [w cString]);
  
  // Creating strings using format strings ala printf.
  int qos = 5;
  NSString *gprsChannel = [NSString stringWithFormat: 
				      @"The GPRS channel is %d",
				    qos];
  printf("Printing a string created using stringWithFormat: %s\
.\n",
	 [gprsChannel cString]);

  NSString *msg = [NSString stringWithFormat:
			      @"Our trading name is %@",
			    w];
  printf("Printing a string created using the %%@ format\
specifier: %s.\n",[msg cString]);

  // Converting C-strings to NSStrings
  char cStr[] = "asdf";
  NSString *nsStr = [NSString stringWithCString: cStr];
  printf("Printing a string created from a C-string: %s.\n",
      [nsStr cString]);

  // Using NSMutableStrings
  NSMutableString *mStr = [NSMutableString stringWithFormat:
					     @"Hi!, %@",
					   w];
  printf("Printing a mutable string: %s.\n",
	 [mStr cString]);
  [mStr appendString: @"**"];	// Modifying in place.
  printf("Printing a mutable string appended with **: %s.\n",
	 [mStr cString]);

  // Writing a string to a file.
  NSString *name = @"This string was created by GNUstep.\n";
  // Enabling "atomically" an existing file will be deleted only 
  // on a successful write.
  
  if ([name writeToFile: @"out" atomically: YES]) {
    NSLog (@"Wrote a string to a file.");
  } 
  else {
    NSLog (@"Failed to write to file.");
  }

  // Reading a string from a file.
  NSString *name2 = [NSString stringWithContentsOfFile: @"out"];
  printf("Printing a string read from a file: %s.\n",
	 [name2 cString]);

  [pool release];
  return 0;
}
