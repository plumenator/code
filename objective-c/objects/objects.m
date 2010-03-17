#include <stdio.h>
#import <Foundation/Foundation.h>

int main() {

  // Obtaining an initialized object.
  id newObj = [[NSString alloc] init]; // Note: +alloc is a class
				       // method, where as -init is
                                       // an instance method.
  
  id anotherObj = [NSString new];	// Shorthand for the above. :-)
  // Note however, that new can be overridden to do more (or even
  // less) than just call +alloc and -init.

  // Initialisation with arguments.
  id cStr = [[NSString alloc] initWithCString: "CString"];
  id fileStr = [[NSString alloc] initWithContentsOfFile: @"out"];

  // Allocating objects from a  specific Zone of memory.
  // id object = [[NSString allocWithZone: zone]];

  // OpenStep-style (Retain/Release) memory management.
  // alloc and copy implicitly call retain.
  NSString *s = [[NSString alloc] initWithContentsOfFile: @"out"];
  [s retain];			// Retain count now 2
  [s retain];			// Retain count now 3
  [s release];			// Retain count now 2
  [s release];			// Retain count now 1
  [s release];			// Retain count now 0, +dealloc gets
				// called.
  // Conventions: 
  // 1) If a block of code causes an object to be allocated, 
  // it "owns" this object and is responsible for releasing it. 
  // If a block of code merely receives a created object from 
  // elsewhere, it is not responsible for releasing it.
  // 2) More generally, the total number of retains in a *block* 
  // should be matched by an equal umber of releases.
  
  NSString *msg = [[NSString alloc] initWithString: 
				      @"Test message."];
  NSLog(msg);
  [msg release];  // we created msg with alloc -- release it

  // Autorelease.
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
  id strin = [NSString new];
  [strin autorelease];
  [pool release];

  return 0;
}
