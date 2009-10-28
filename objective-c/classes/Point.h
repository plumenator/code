// -*-ObjC-*-

#import <Foundation/NSObject.h>

@interface Point : NSObject
{
@private
    // instance variables only accessible to instances of this class
@protected
    // instance variables accessible to instances of this class or
    // subclasses
  float x;
  float y;
@public
    // instance variables accessible by all code ...
}

// class methods
+ (id) new;
+ (id) newWithX: (float)x0 Y: (float)y0;
+ (Point*) point;
+ (Point*) pointWithX: (float)x0 Y: (float)y0;

// instance methods
- (id) init;
- (id) initWithX: (float)x0 Y: (float)y0;
- (float) x;  // (field accessor)
- (float) y;
- (void) setX: (float)newX;
- (void) setY: (float)newY;
@end
