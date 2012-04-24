module Main where
import Data.List(intercalate)
import System.Environment
import Control.Monad.State

main = do
  cn     <- getContents
  putStr .unlines .map splitWords . lines $cn
splitWords :: String -> String
splitWords str = evalState (parsed str) ' '

parsed :: String -> State Char String
parsed [] = return []
parsed (x:xs) = do 
  st <- get
  return $ case (x:st:[]) of
             "  "      -> (','  :(evalState (parsed xs) ' '))
             "\" "     -> ('"'  :(evalState (parsed xs) '"'))
             "' "      -> ('\'' :(evalState (parsed xs) '\''))
             " \""     -> (' '  :(evalState (parsed xs) '"'))
             "\"\""    -> ('"'  :(evalState (parsed xs) ' '))
             "'\""     -> ('\'' :(evalState (parsed xs) '"'))
             " '"      -> (' '  :(evalState (parsed xs) '\''))
             "\"'"     -> ('"'  :(evalState (parsed xs) '\''))
             "''"      -> ('\'' :(evalState (parsed xs) ' '))
             _         -> (x    :(evalState (parsed xs) st))