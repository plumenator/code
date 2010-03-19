splitWith :: (a -> Bool) -> [a] -> [[a]]
splitWith _ [] = []
splitWith p xs = first:(splitWith p (dropWhile (not . p) rest))
    where first = (takeWhile p xs)
          rest = (dropWhile p xs)