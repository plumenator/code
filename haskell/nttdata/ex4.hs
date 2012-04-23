module Main where
import Data.List(intercalate)
import System.Environment
import Control.Monad.State

main = do
  cn     <- getContents
  putStr .unlines .map splitWords . lines $cn
splitWords :: String -> String
splitWords str = f where
  f = evalState (parsed str) ' '

parsed [] = return []
parsed (x:xs) = do 
  s <- get
  return (if x /= s then (x:(evalState (parsed xs) s)) else (',':(evalState (parsed xs) s)))