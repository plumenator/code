#include <stdio.h>
#import <Foundation/Foundation.h>
#import "Point.h"

int main() {

  NSAutoreleasePool *pool = [NSAutoreleasePool new];

  Point *p = [Point pointWithX: 1 Y: 2];
  printf("X is %f. Y is %f.\n",[p x],[p y]);

  [pool release];
  return 0;
}
