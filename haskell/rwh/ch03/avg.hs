avg :: (Fractional t) => [t] -> t
avg [] = 0
avg xs = sum xs / fromIntegral (length xs)