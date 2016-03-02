module Main where

import Data.ByteString.Lazy as B (readFile, unpack)
import System.Environment (getArgs)

import Lib

main :: IO ()
main = getArgs >>= return . parseArgs >>= B.readFile >>= print . map toInteger . unpack . pcapHeader

parseArgs :: [String] -> String
parseArgs [st] = st
parseArgs _    = error "parseArgs: Exactly one file name in arguments"
