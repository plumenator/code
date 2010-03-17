import Data.List

split :: Eq a => [a] -> a -> [[a]]
split [] _ = []
split xs x = ps:(split (tail' qs) x)
    where (ps,qs) = break (==x) xs
          tail' xs = if xs == [] then [] else tail xs