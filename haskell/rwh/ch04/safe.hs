-- Elegance:
safeFunc :: ([a] -> b) -> [a] -> Maybe b
safeFunc f xs | null xs = Nothing
              | otherwise = Just (f xs)

safeHead = safeFunc head
safeTail = safeFunc tail
safeLast = safeFunc last
safeInit = safeFunc init

-- Brute force. :-)
-- safeHead :: [a] -> Maybe a
-- safeHead xs | null xs =  Nothing
--             | otherwise = Just (head xs)

-- safeTail :: [a] -> Maybe [a]
-- safeTail xs | null xs = Nothing
--             | otherwise = Just (tail xs)

-- safeLast :: [a] -> Maybe a
-- safeLast xs | null xs = Nothing
--             | otherwise = Just (last xs)

-- safeInit :: [a] -> Maybe [a]
-- safeInit xs | null xs = Nothing
--             | otherwise = Just (init xs)
