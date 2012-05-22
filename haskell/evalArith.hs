module Main where
import Data.Char(isDigit)

tokenize :: String -> [String]
tokenize exp = tok exp ""
  where tok "" "" = []
        tok "" ys = [ys]
        tok (x:xs) "" = tok xs (x:[])
        tok (x:xs) curr@(y:ys) = if (isDigit x `xor` isDigit y) then curr:(tok xs [x])
                                 else if (isOperand x) then curr:[x]:(tok xs "")
                                      else (tok xs (curr ++ [x]))
        xor = (/=)
        isOperand '*' = True
        isOperand '+' = True
        isOperand '-' = True
        isOperand '/' = True
        isOperand _   = False