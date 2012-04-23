module Main where
import System.Environment
main = do
   cn <- getContents
   putStr . unlines . filterAddHeader . lines $ cn
filterAddHeader :: [String] -> [String]
filterAddHeader = f where
    f lis = map g (zip [1..] lis)
    g li = (show $ fst li) ++ (snd li)
