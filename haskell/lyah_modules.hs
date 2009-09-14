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

