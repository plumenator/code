module Main where

main = do
  cn <- getContents
  putStr . unlines . map splitWords . lines $ cn

splitWords :: String -> String
splitWords  =  parsed ' '

parsed :: Char -> String -> String
parsed _ "" = ""
parsed st (x:xs) = res : parsed newSt xs
  where (res, newSt) = 
          case (x:st:[]) of
            "  "   -> (',', ' ')
            "\" "  -> ('"', '"')
            "' "   -> ('\'', '\'')
            " \""  -> (' ', '"')
            "\"\"" -> ('"', ' ')
            "'\""  -> ('\'', '"')
            " '"   -> (' ', '\'')
            "\"'"  -> ('"', '\'')
            "''"   -> ('\'', ' ')
            _      -> (x, st)