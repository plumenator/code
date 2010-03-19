solveRpn :: (Num a) => String -> a
solveRpn expression = head (foldl step [] (words expression))
    where step [] item | item == '+'