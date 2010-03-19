-- Thanks to Vineet Kumar (http://doorstop.net/)

import System.Environment (getArgs)

interactWith function inputFile outputFile = do
  input <- readFile inputFile
  writeFile outputFile (function input)

main = mainWith myFunction
  where mainWith function = do
          args <- getArgs
          case args of
            [input,output] -> interactWith function input output
            _ -> putStrLn "error: exactly two arguments needed"

        myFunction = unlines . transpose . lines

transpose :: [String] -> [String]
transpose [] = []
transpose xs | all null xs = []
             | otherwise = heads : transpose tails
             where heads = concat (map (take 1) xs)
                   tails = map (drop 1) xs
