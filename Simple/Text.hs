{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE TypeSynonymInstances #-}

module Simple.Text (
    Text,
    ToText,
    toText,
    appendChar,
    appendText,
    isEmptyOrWhitespaceText,
    isEmptyText,
    lengthText,
    prependChar,
    replaceText,
    splitText,
    toLowerText,
    toUpperText,
    trimText,
    trimStartText,
    trimEndText,
    compareText,
    compareIgnoreCaseText,
    containsText,
    containsIgnoreCaseText,
    equalsText,
    equalsIgnoreCaseText,
    startsWithText,
    startsWithIgnoreCaseText,
    endsWithText,
    endsWithIgnoreCaseText,
    indexOfAnyChar,
    indexOfAnyIgnoreCaseChar,
    indexOfChar,
    indexOfIgnoreCaseChar,
    indexOfText,
    indexOfIgnoreCaseText,
    lastIndexOfAnyChar,
    lastIndexOfAnyIgnoreCaseChar,
    lastIndexOfChar,
    lastIndexOfIgnoreCaseChar,
    lastIndexOfText,
    lastIndexOfIgnoreCaseText
) where
    
import qualified Data.Char as C
import qualified Data.Text as T

type Text = T.Text

-- Conversions
class ToText a where
    toText :: a -> Text

instance ToText Char where
    toText = T.singleton

instance ToText String where
    toText = T.pack

-- Basic interface

appendChar :: Text -> Char -> Text
appendChar = T.snoc

appendText :: Text -> Text -> Text
appendText = T.append

isEmptyOrWhitespaceText :: Text -> Bool
isEmptyOrWhitespaceText text = isEmptyText $ trimText text

isEmptyText :: Text -> Bool
isEmptyText = T.null

lengthText :: Text -> Int
lengthText = T.length

prependChar :: Text -> Char -> Text
prependChar text char = T.cons char text

-- Transformations

replaceText :: Text -> (Text, Text) -> Text
replaceText text (find, replace) = T.replace find replace text

splitText :: Text -> Text -> [Text]
splitText = T.splitOn

toLowerText :: Text -> Text
toLowerText = T.toLower

toUpperText :: Text -> Text
toUpperText = T.toUpper

trimText :: Text -> Text
trimText = T.strip

trimStartText :: Text -> Text
trimStartText = T.stripStart

trimEndText :: Text -> Text
trimEndText = T.stripEnd

-- Comparisons

compareText :: Text -> Text -> Ordering
compareText = compare

compareIgnoreCaseText :: Text -> Text -> Ordering
compareIgnoreCaseText left right = (T.toCaseFold left) `compare` (T.toCaseFold right)

containsText :: Text -> Text -> Bool
containsText text value = T.isInfixOf value text

containsIgnoreCaseText :: Text -> Text -> Bool
containsIgnoreCaseText text value = T.isInfixOf (T.toCaseFold value) (T.toCaseFold text)

equalsText :: Text -> Text -> Bool
equalsText = (==)

equalsIgnoreCaseText :: Text -> Text -> Bool
equalsIgnoreCaseText left right = T.toCaseFold left == T.toCaseFold right

startsWithText :: Text -> Text -> Bool
startsWithText text prefix = T.isPrefixOf prefix text

startsWithIgnoreCaseText :: Text -> Text -> Bool
startsWithIgnoreCaseText text prefix = T.isPrefixOf (T.toCaseFold prefix) (T.toCaseFold text)

endsWithText :: Text -> Text -> Bool
endsWithText text suffix = T.isSuffixOf suffix text

endsWithIgnoreCaseText :: Text -> Text -> Bool
endsWithIgnoreCaseText text suffix = T.isSuffixOf (T.toCaseFold suffix) (T.toCaseFold text)

-- Searching

indexOfAnyChar :: Text -> [Char] -> Maybe Int
indexOfAnyChar text chars = T.findIndex (`elem` chars) text

indexOfAnyIgnoreCaseChar :: Text -> [Char] -> Maybe Int
indexOfAnyIgnoreCaseChar text chars = T.findIndex (`elem` (map C.toLower chars)) (T.toLower text)

indexOfChar :: Text -> Char -> Maybe Int
indexOfChar text char = T.findIndex (char==) text

indexOfIgnoreCaseChar :: Text -> Char -> Maybe Int
indexOfIgnoreCaseChar text char = T.findIndex ((C.toLower char)==) (T.toLower text)

indexOfText :: Text -> Text -> Maybe Int
indexOfText text value = if T.null match then Nothing else (Just $ lengthText prefix)
    where (prefix, match) = T.breakOn value text

indexOfIgnoreCaseText :: Text -> Text -> Maybe Int
indexOfIgnoreCaseText text value = (T.toCaseFold text) `indexOfText` (T.toCaseFold value)

lastIndexOfAnyChar :: Text -> [Char] -> Maybe Int
lastIndexOfAnyChar text chars = reverseIndex text 1 $ T.findIndex (`elem` chars) (T.reverse text)

lastIndexOfAnyIgnoreCaseChar :: Text -> [Char] -> Maybe Int
lastIndexOfAnyIgnoreCaseChar text chars = reverseIndex text 1 $ T.findIndex (`elem` (map C.toLower chars)) (T.toLower $ T.reverse text)

lastIndexOfChar :: Text -> Char -> Maybe Int
lastIndexOfChar text char = reverseIndex text 1 $ T.findIndex (char==) (T.reverse text)

lastIndexOfIgnoreCaseChar :: Text -> Char -> Maybe Int
lastIndexOfIgnoreCaseChar text char = reverseIndex text 1 $ T.findIndex ((C.toLower char)==) (T.toLower $ T.reverse text)

lastIndexOfText :: Text -> Text -> Maybe Int
lastIndexOfText text value = reverseIndex text (T.length value) $ if T.null match then Nothing else (Just $ lengthText prefix)
    where (prefix, match) = T.breakOn (T.reverse value) (T.reverse text)

lastIndexOfIgnoreCaseText :: Text -> Text -> Maybe Int
lastIndexOfIgnoreCaseText text value = (T.toCaseFold text) `lastIndexOfText` (T.toCaseFold value)

-- Helpers

reverseIndex :: Text -> Int -> Maybe Int -> Maybe Int
reverseIndex _ _ Nothing = Nothing
reverseIndex text matchLength (Just value) = Just $ T.length text - value - matchLength
