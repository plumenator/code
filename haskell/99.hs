-- Problem 1
-- Find the last element of a list.
myLast :: [a] -> a
myLast (x:[]) = x
myLast (x:xs) = myLast xs

myLast' = foldr1 (const id)

-- Problem 2
-- Find the last but one element of a list.
myLastButOne :: [a] -> a
myLastButOne  = last . init

-- Problem 3
-- Find the K'th element of a list. The first element in the list
-- is number 1.
elementAt :: [a] -> Int -> a
elementAt lst pos = lst !! (pos - 1)

-- Problem 4
-- Find the number of elements of a list
myLength :: [a] -> Int
myLength = foldr (\x n -> n + 1) 0

-- Problem 5
-- Reverse a list.
myReverse :: [a] -> [a]
myReverse = foldl (\x y -> y:x) []

myReverse' = foldl (flip (:)) []

-- Problem 6
-- Find out whether a list is a palindrome.
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = xs == (reverse xs)

-- Problem 7
-- Flatten a nested list.
-- TODO

-- Problem 8
-- Eliminate consecutice duplicates of list elements.
compress :: (Eq a) => [a] -> [a]
compress [x] = [x]
compress (x:xs) = if (x == (head xs)) 
                  then (compress xs)
                  else x:(compress xs)

-- Problem 9
-- Pack consecutive duplicates of list elements into sublists.
-- If a list contains repeated elements then should be placed in 
-- separate sublists.
pack :: (Eq a) => [a] -> [[a]]
pack [] = []
pack (x:xs) = (x:(takeWhile (==x) xs)) :
              (pack $ dropWhile ((==x)) xs)

-- Problem 10
-- Run-length encoding of a list. Use the result of P9 to
-- implement the so-called run-length encoding data compression
-- method. Consecutive duplicates of elements are encoded as lists
-- (N E) where N is the number of duplicates of the element E.
rlencode :: (Eq a) => [a] -> [(Int, a)]
rlencode  = map (\x -> (length x,head x)) . pack

-- Problem 11
-- Modified run-length encoding. Modify the result of P10 in such 
-- a way that if an element has no duplicates it is simply copied 
-- into  the result list.
-- TODO
-- rlencode'

-- Problem 12
-- Decode a run-length encoded list. Given a run-length code list 
-- generated as specified in P11. Construct its uncompressed 
-- version.
rldecode  = concatMap (\x -> replicate (fst x) (snd x))
-- rldecode'

-- Problem 13
-- Run-length encoding of a list (direct solution). Implement the
-- so-called run-length encoding data compression method directly. 
-- I.e. don't explicitly create the sublists containing the
-- duplicates, as in problem 9, but only count them. As in problem
-- P11, simplify the result list by replacing the singleton lists
-- (1 X) by X. 
rlencodeDirect :: (Eq a) => [a] -> [(Int, a)]
rlencodeDirect = foldl helper []
    where
      helper [] x = [(1,x)]
      helper (y:ys) x
          | x == snd y  = (1 + fst y,x):ys
          | ys == []    = (1,x):y:[]
          | otherwise   = (1,x):y:ys

-- Problem 14
-- Duplicate the elements of a list.
-- Example:
-- > dupli [1,2,3]
-- [1,1,2,2,3,3]
dupli :: [a] -> [a]
dupli = foldr (\x xs -> x:x:xs) [] 
-- or dupli (x:xs) = x:x:dupli xs

-- Problem 15
-- Replicate the elements of a list a given number of times.
repli :: [a] -> Int -> [a]
repli xs n = concatMap (replicate n) xs

-- Problem 16
-- Drop every N'th element from a list.
dropEvery :: [a] -> Int -> [a]
dropEvery xs n
     | length xs >= 3  = (\(x,y) n -> init x ++ dropEvery y n) 
                         (splitAt n xs) n
     | otherwise       = xs

-- Problem 17
-- Split a list into two parts; the length of the first part is 
-- given.
-- Note: Do not use any predefined predicates.
split :: [a] -> Int -> ([a],[a])
split xs n = (take n xs,drop n xs)
--or split (x:xs) n = let (f,l) = split xs (n-1) in (x : f, l)

-- Problem 18
-- Extract slice from a list
slice :: [a] -> Int -> Int -> [a]
slice xs (i+1) k = take (k-i) $ drop i xs

