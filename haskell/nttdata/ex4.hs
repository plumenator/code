module Main where

main = do
  cn <- getContents
  putStr . unlines . map splitWords . lines $ cn

splitWords :: String -> String
splitWords  =  parsed ' '

parsed :: Char -> String -> String
parsed _ "" = ""
parsed st (x:xs) =
  case (x:st:[]) of
    "  "   -> ','  : parsed ' '  xs
    "\" "  -> '"'  : parsed '"'  xs
    "' "   -> '\'' : parsed '\'' xs
    " \""  -> ' '  : parsed '"'  xs
    "\"\"" -> '"'  : parsed ' '  xs
    "'\""  -> '\'' : parsed '"'  xs
    " '"   -> ' '  : parsed '\'' xs
    "\"'"  -> '"'  : parsed '\'' xs
    "''"   -> '\'' : parsed ' '  xs
    _      -> x    : parsed st   xs