-- file: ch03/Tree.hs
data Tree a = Node a (Tree a) (Tree a)
            | Empty
              deriving (Show)

data MaybeTree a = MaybeNode (Maybe a) (Maybe (MaybeTree a)) (Maybe (MaybeTree a))
                   deriving (Show)