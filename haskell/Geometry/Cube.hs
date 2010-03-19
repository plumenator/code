module Geometry.Cube
( volume
, area
) where

import qualified Geometry.Cuboid as Cuboid

volume :: Float -> Float
volume side =  Cuboid.volume side side side

cubeArea :: Float -> Float
cubeArea side = Cuboid.area side side side
