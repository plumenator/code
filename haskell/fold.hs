foldl' :: (a -> a -> a) -> a -> [a] -> a
foldl' _ x [] = x
foldl' f x (y:ys) = foldl' f (f x y) ys

sum' :: (Num a) => [a] -> a
sum' = foldl' (\x y -> x + y) 0

foldr' :: (a -> a -> a) -> a -> [a] -> a
foldr' _ x [] = x
foldr' f x xs = foldl' f x (reverse xs)

avg' :: (Fractional a) => [a] -> a
avg' xs = foldr' (\x y -> x + (y/len)) 0 xs
    where len = fromIntegral (length xs)

