-- Record syntax
data Person = Person { firstName :: String -- field names are
                     , lastName :: String  -- automagically functions
                     , age :: Int
                     , height :: Float
                     , phoneNumber :: String
                     , flavor :: String
                     } deriving (Show)

data Car = Car {company :: String, model :: String, year :: Int}
           deriving (Show)

aCar = Car {company="Ford", model="Mustang", year=1967} -- creating
                                                        -- car values



