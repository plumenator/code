data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

height :: Tree a -> Int
height Empty = 0
height (Node n t1 t2) = 1 + (max (height t1) (height t2))