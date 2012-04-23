module Main where
import Control.Monad.State
import System.Environment
main = do
  cn <- getContents
  (st, ad) <- runStateT(addLineNumber(lines cn)) 1
  putStr $ unlines st
addLineNumber :: [String] -> StateT Int IO [String]
addLineNumber = f where
  f     = mapM g
  g li = put 2 >> liftM(h li) get
  h li ln = show ln ++ " " ++ li
