#import "PointTransformable.h"

@implementation Point (Transformable)
- (void) translateByX: (float)tx Y: (float)ty
{
  x += tx;
  y += ty;
  return self;
}

- (void) rotateByAngle: (float)radians
{
  // ...
}

- (void) scaleByAmountX: (float)xscale Y: (float)yscale
{
  // ...
}
@end
