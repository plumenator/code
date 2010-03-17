doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

doubleSmallNumber x = if x > 100
                      then x
                      else x*2

doubleSmallNumber' x = doubleSmallNumber x + 1

boomBangs xs = [if x < 10
                then "BOOM!" 
                else "BANG" 
                | x <- xs]

length' xs = sum [1 | _ <- xs]

maximum' :: (Ord a) => [a] -> a
maximum' [] = error "maximum' of an empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

replicate' :: (Num i,Ord i) => i -> a -> [a]
replicate' n x
    | n <= 0 = []
    | otherwise = x:replicate' (n-1) x

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
    | n <= 0    = []
take' _ []      = []
take' n (x:xs)  = x : take' (n-1) xs

repeat' :: a -> [a]
repeat' x = x:repeat' x

reverse' :: [a] -> [a]
reverse' [] = []
reverse' xs = reverse' (tail xs) ++ [head xs]

zip' :: [a] -> [b] -> [(a,b)]
zip' [] _ = []
zip' _ [] = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' _ [] = False
elem' a (x:xs)
    | a == x = True
    | otherwise = a `elem'` xs

quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
    let smaller = quicksort [a | a <- xs, a <= x]
        bigger = quicksort [a | a <- xs, a > x]
    in smaller ++ [x] ++ bigger

halve :: (Fractional a) => a -> a
halve = (/2)

applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

quarter :: (Fractional a) => a -> a
quarter = halve . halve

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ _ [] = []
zipWith' _ [] _ = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x
-- or 
-- flip' :: (a -> b -> c) -> b -> a -> c
-- flip' f x y = f y x

map' :: (a -> b) -> [a] -> [b]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x = x : filter' p xs
    | otherwise = filter' p xs

minus = \ a b -> subtract b a
-- 3 `minus` 4 -=> -1

