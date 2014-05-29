-----------------------------------------------------------------------------
-- |
-- Module      :  Simple.String
-- Copyright   :  See LICENSE file
-- License     :  Apache 2.0
--
-- Maintainer  :  Steve G. Bjorg <steve.bjorg@gmail.com>
-- Stability   :  experimental
-- Portability :  portable (not tested)
--
-----------------------------------------------------------------------------

module Simple.String (
    ToString,
    toString
) where

import qualified Data.Text as T

class ToString a where
    toString :: a -> String

instance ToString T.Text where
    toString = T.unpack
