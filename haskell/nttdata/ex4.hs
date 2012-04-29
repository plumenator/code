module Main where
import Data.List(intercalate)
import System.Environment
import Control.Monad.State

main = do
  cn     <- getContents
  putStr .unlines .map splitWords . lines $cn
splitWords :: String -> String
splitWords str =  parsed str ' '

parsed :: String -> Char -> String
parsed "" _ = ""
parsed (x:xs) st =
  case (x:st:[]) of
    "  "      -> (','  :(parsed xs ' '))
    "\" "     -> ('"'  :(parsed xs '"'))
    "' "      -> ('\'' :(parsed xs '\''))
    " \""     -> (' '  :(parsed xs '"'))
    "\"\""    -> ('"'  :(parsed xs ' '))
    "'\""     -> ('\'' :(parsed xs '"'))
    " '"      -> (' '  :(parsed xs '\''))
    "\"'"     -> ('"'  :(parsed xs '\''))
    "''"      -> ('\'' :(parsed xs ' '))
    _         -> (x    :(parsed xs st))