#import "Point.h"

@implementation Point

+ (id)new
{
  return [[self alloc] init];
}

+ (id) newWithX: (float)x0 Y: (float)y0
{
  return [[self alloc] initWithX: x0 Y: y0];
}

+ (Point*) point
{
  Point *point = [[self alloc] init];
  [point autorelease];
  return point;
}

+ (Point*) pointWithX: (float)x0 Y: (float)y0
{
  Point *point = [[self alloc] initWithX: x0 Y: y0];
  [point autorelease];
  return point;
}

- (id) init
{
  return [self initWithX: 0 Y: 0];
}

- (id) initWithX: (float)x0 Y: (float)y0 // Designated initializer.
{
  self = [super init];
  if (self != nil) {
    [self setX: x0];
    [self setY: y0];
  }
  return self;
}

- (float) x
{
  return x;
}

- (float) y
{
  return y;
}

- (void) setX: (float)newX
{
  x = newX;
}

- (void) setY: (float)newY
{
  y = newY;
}

- (void) dealloc
{
  [super dealloc];
}

@end
