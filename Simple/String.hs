module Simple.String (
    ToString,
    toString
) where

import qualified Data.Text as T

class ToString a where
    toString :: a -> String

instance ToString T.Text where
    toString = T.unpack
