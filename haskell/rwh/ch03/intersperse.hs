myIntersperse :: a -> [[a]] -> [a]
myIntersperse y [x] = x
myIntersperse y (x:xs) = x ++ [y] ++ (myIntersperse y xs)