-----------------------------------------------------------------------------
-- |
-- Module      :  Simple.Control
-- Copyright   :  See LICENSE file
-- License     :  Apache 2.0
--
-- Maintainer  :  Steve G. Bjorg <steve.bjorg@gmail.com>
-- Stability   :  experimental
-- Portability :  portable (not tested)
--
-----------------------------------------------------------------------------

module Simple.Maybe (
    (??)
) where

(??) :: Maybe a -> a -> a
(??) Nothing other = other
(??) (Just value) _ = value
