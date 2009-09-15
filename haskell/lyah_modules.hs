-- This file contains the notes I made for Chapter 7 (Modules) of Learn You a Haskell.

--nub weeds out the duplicates in a list
import Data.List
numUniques :: (Eq a) => [a] -> Int
numUniques = length . nub

-- Implementing nub:
nub' :: (Eq a) => [a] -> [a]
nub' (x:xs) = if x `isin` xs then nub' xs else x:(nub' xs)
    where isin :: (Eq a) => a -> [a] -> Bool 
          isin x [] = False
          isin x (y:ys) = if x == y then True else x `isin` ys
nub' [] = []

-- Importing module members
-- import Data.List (nub, sort)

-- Excluding modules members
-- import Data.List hiding (nub)

-- Qualified import
-- import qualified Data.Map

-- "Aliased" import
-- import qualified Data.Map as M

{-- Data.List
   The various functions contained in the module, Data.List.
   My implementations of them. :-)
--}


-- intersperse 
--
-- Prelude Data.List> intersperse '.' "MONKEY"
-- "M.O.N.K.E.Y" Prelude Data.List> intersperse [1,2,3]
-- [[1],[3,5,6],[6,7,8,5]] [[1],[1,2,3],[3,5,6],[1,2,3],[6,7,8,5]]
-- Prelude Data.List>

intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' _ [x] = [x]
intersperse' y (x:xs) = x:y:(intersperse y xs)

-- intercalate
--
-- *Main Data.List> intercalate " " ["hey","there","guys"]
-- "hey there guys"
-- *Main Data.List> intercalate [0,0,0] [[1,2,3],[4,5,6],[7,8,9]]
-- [1,2,3,0,0,0,4,5,6,0,0,0,7,8,9]
-- *Main Data.List> 

intercalate' :: [a] -> [[a]] -> [a]
intercalate' _ [] = []
intercalate' _ [x] = x
intercalate' ys (xs:xss) = xs ++ ys ++ (intercalate' ys xss)

-- transpose
-- 
-- *Main Data.List> transpose ["Asdf","fda","afew"]
-- ["Afa","sdf","dae","fw"]
-- *Main Data.List> transpose [[1,2,3,4],[5,6,7,8]]
-- [[1,5],[2,6],[3,7],[4,8]]
-- *Main Data.List> 

transpose' :: [[a]] -> [[a]]
transpose' [] = []
transpose' xss = heads : (transpose' tails)
    where heads = [head xs | xs <- xss, length xs /= 0]
          tails = [tail ys | ys <- xss, length ys > 1]

-- concat
-- 
-- *Main> concat ["foo","bar","car"]
-- "foobarcar"
-- *Main> 

concat' :: [[a]] -> [a]
concat' [] = []
concat' (xs:xss) = xs ++ (concat' xss)

-- concatMap
--
-- *Main> concatMap (replicate 4) [1..3]
-- [1,1,1,1,2,2,2,2,3,3,3,3]
-- *Main> 
concatMap' :: (a -> [b]) -> [a] -> [b]
concatMap' f = concat . (map f)

