module Lib
    ( pcapHeader
    ) where

import Data.ByteString.Lazy as B (ByteString, take)

pcapHeader :: B.ByteString -> B.ByteString
pcapHeader = B.take 24
