module Main where
import Data.List(intercalate)
import Data.List.Split(splitEvery)
import System.Environment
import Control.Monad.State

main = do
  ags <- getArgs
  putStrLn $ similarScanf(ags !! 0)(ags !! 1)
similarScanf :: String -> String -> String
similarScanf = f where
  f pt ags = intercalate "," $ evalState (parsePt (splitEvery 3 $ pt)) ags

parsePt = mapM g where
    g ('%':wd:kd)
        | kd == "x" = liftM hex2int parsed
        | kd == "d" = liftM str2int parsed
        | otherwise = parsed
        where parsed = (h (read (wd:[]) :: Int))
    h width = do
      s <- get
      put (drop width s)
      return (take width s)

-- Discards trailing non numeric characters
str2int :: String -> String
str2int = takeWhile (\x -> x >= '0' && x <= '9')

-- Assumes the input contains only legal hex digits
hex2int :: String -> String
hex2int str = show (hex2int' $ reverse str)
    where
      hex2int' :: String -> Int
      hex2int' (x:xs) = (num x) + 16*(hex2int' xs)
      hex2int' [] = 0
      num x
          | x == 'a' = 10
          | x == 'b' = 11
          | x == 'c' = 12
          | x == 'd' = 13
          | x == 'e' = 14
          | x == 'f' = 15
          | otherwise = (read (x:[]) :: Int)