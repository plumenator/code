palindromify :: [a] -> [a]
palindromify xs = xs ++ reverse xs
    where reverse (y:ys) = (reverse ys) ++ [y]
          reverse [] = []