import Data.List
import  Data.Ord

data Direction = LeftTurn | RightTurn | Straight deriving (Show, Eq)

type Point = (Double, Double)

turn :: Point -> Point -> Point -> Direction
turn (x0, y0) (x1, y1) (x2 ,y2) 
    | signedArea > 0 = LeftTurn
    | signedArea < 0 = RightTurn
    | otherwise = Straight
    where signedArea = ((x1 - x0) * (y2 - y0) - (x2 - x0) * (y1 - y0)) / 2

turns :: [Point] -> [Direction]
turns (x0:x1:x2:xs) = (turn x0 x1 x2):(turns (x1:x2:xs))
turns xs = [LeftTurn]

southWestMost :: [Point] -> Point
southWestMost [x] = x
southWestMost (x:xs) = southWestOne x (southWestMost xs)
    where southWestOne (x0, y0) (x1, y1)
              | y0 < y1 = (x0, y0)
              | y0 == y1 && x0 < x1 = (x0, y0)
              | otherwise = (x1, y1)

filterRightTurns :: [Point] -> [Point]
filterRightTurns points = (head points):(map fst (filter (\(p,d) -> d /= RightTurn) (zip (tail points) (turns points))))

slope :: Point -> Point -> Double
slope (x1, y1) (x0, y0) =  (y1 - y0) / (x1 - x0)

convexHullIter  :: [Point] -> [Point]
convexHullIter points = filterRightTurns (pivot:(sortBy (comparing angleWithPivot) rest))
    where pivot = southWestMost points
          rest = filter ((/=)  pivot) points
          angleWithPivot a = -1 / (slope a pivot)

convexHull :: [Point] -> [Point]
convexHull points = if (length newPoints) == (length points) then points else (convexHull newPoints)
    where newPoints = convexHullIter points