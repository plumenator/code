import Data.List

sortByLength :: [[a]] -> [[a]]
sortByLength = sortBy compareLengths
    where compareLengths xs ys = compare (length xs) (length ys)