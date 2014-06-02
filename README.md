Simple
======

A Haskell package to simplify common functionality that recovering imperative programmers might be missing.

# Installing

The package definition has not yet been submitted to enable a simple `cabal` installation. Luckily, doing it using `git` is not that much harder:
```
git clone https://github.com/bjorg/Simple.git
cabal install Simple
```

# Module: Simple.Maybe

### (??) :: Maybe a -> a -> a
Check if a Maybe value has an actual value or not. If it does, return the actual value, otherwise return the second argument as default value.

```haskell
ghci > (Just 1) ?? 2
1
ghci > Nothing ?? 2
2
```

# Module: Simple.Text

Collection of functions to operate on `Text` values. `Simple.Text` is built on `Data.Text` and fully compatible with it. It exposes most of the functions with new, more expressive names. In addition, it also provides new convenience functions for case-insensitive operations. Function names are explicit enough to avoid the module needing to be included in a qualified manner. Aside from making the entire module available at once, it also promotes better code readability.

Make sure to use the `OverloadedStrings` extension to avoid explicit `toText` calls for string literals. The samples in this document assume the extension is enabled.

To get started using `ghci`, enter the following:
```
~> ghci -XOverloadedStrings
ghci > :m + Simple.Text
```

Different from traditional Haskell functions, the primary argument is the `Text` value to be operated on. For instance:
```haskell
ghci > "hello world" `startsWithText` "hello"
True
```

## Conversions

`Simple.Text` introduces the `ToText` type class, which is used for all conversions to `Text` values. Using a type class makes it easy to introduce additional conversions from other types without introducing hard to remember names.

The `ToText` type class is defined as follows:
```haskell
class ToText a where
    toText :: a -> Text
```

### toText :: Char -> Text
Convert a character to a `Text` value.

```haskell
ghci > toText '!'
"!"
```
### toText :: String -> Text
Convert a string value to a `Text` value.

```haskell
ghci > toText "hi!"
"hi!"
```
## Basic interface

### appendChar :: Text -> Char -> Text
Append a character to a `Text` value.

```haskell
ghci > "hi" `appendChar` '!'
"hi!"
```

### appendText :: Text -> Text -> Text
Append the second `Text` value to the first.

```haskell
ghci > "hello" `appendText` " world!"
"hello world!"
```

### lengthText :: Text -> Int
Get the length of a `Text` value.

```haskell
ghci > lengthText "hi"
2
```

### prependChar :: Text -> Char -> Text
Append a character to the beginning of a `Text` value.

```haskell
ghci > "i!" prependChar 'h'
"hi!"
```

### prependText :: Text -> Text -> Text
Append the second `Text` value to the beginning of the first value.

```haskell
ghci > "world!" `prependText` "hello "
"hello world!"
```

## Transformations

### headText :: Text -> Int -> Text
Only keep the first count characters of the `Text` value.

```haskell
ghci > "helloWorld" `headText` 5
"hello"
```

### joinText :: Text -> [Text] -> Text
Join all `Text` values into a single `Text` value using the first argument as separator between them.

```haskell
ghci > joinText " " ["hello","world"]
"hello world"
```

### removeChar :: Text -> Char -> Text
Remove all occurrences of a `Char` value from the `Text` value.

```haskell
ghci > "hello world" `removeChar` 'l'
"heo word"
```

### removeText :: Text -> Text -> Text
Remove all occurrences of the second `Text` value from the first one.

```haskell
ghci > "hello world" `removeText` "ll"
"heo world"
```

### replaceText :: Text -> (Text, Text) -> Text
Replace all occurrences of a `Text` value with another. The first argument is the `Text` value in which to perform the substitutions. The second argument is a tuple with the `Text` value to search for and its replacement.

```haskell
ghci > "hi!" `replaceText` ("hi", "bye")
"bye!"
```

### splitText :: Text -> Text -> [Text]
Split a `Text` value on each occurrence of the second argument.

```haskell
ghci > "hello world" `splitText` " "
["hello", "world"]
```

### subText :: Text -> (Int, Int) -> Text

```haskell
ghci > "hello world" `subText` (2, 2)
"ll"
ghci > subText "hello world" (0, 100)
"hello world"
ghci > subText "hello world" (100, 0)
""
```

### tailText :: Text -> Int -> Text
Skip the first count characters in `Text` value and return the remaining tail.

```haskell
ghci > "hello world" `tailText` 6
"world"
```

### toLowerText :: Text -> Text
Convert a `Text` value to its lowercase equivalent. Note this conversion is not locale specific.

```haskell
ghci > toLowerText "Hi!"
"hi!"
```

### toUpperText :: Text -> Text
Convert a `Text` value to its uppercase equivalent. Note this conversion is not locale specific.

```haskell
ghci > toUpperText "hi!"
"HI!"
```

### trimText :: Text -> Text
Remove whitespace from the beginning and end of the `Text` value.

```haskell
ghci > trimText "  hi!  "
"hi!"
```

### trimEndText :: Text -> Text
Remove whitespace only from the end of the `Text` value.

```haskell
ghci > trimEndText "  hi!  "
"  hi!"
```

### trimStartText :: Text -> Text
Remove whitespace only from the beginning of the `Text` value.

```haskell
ghci > trimStartText "  hi!  "
"hi!  "
```

## Comparisons

### compareText :: Text -> Text -> Ordering
Compare two `Text` values.

```haskell
ghci > "hi" `compareText` "bye"
GT
```

### compareIgnoreCaseText :: Text -> Text -> Ordering
Compare two `Text` values in case-insensitive manner.

```haskell
ghci > "hi" `compareIgnoreCaseText` "Hi"
EQ
```

### containsText :: Text -> Text -> Bool
Check if the second `Text` value is contained in the first `Text` value.

```haskell
ghci > "hello world" `containsText` "hello"
True
```
### containsIgnoreCaseText :: Text -> Text -> Bool
Check if the second `Text` value is contained in the first `Text` value in a case-insentitive manner.

```haskell
ghci > "hello world" `containsText` "WORLD"
True
```

### equalsText :: Text -> Text -> Bool
Compare if two `Text` values are identical.

```haskell
ghci > "hi" `equalsText` "hi"
True
```

### equalsIgnoreCaseText :: Text -> Text -> Bool
Compare if two `Text` values are identical in a case-insensitive manner.

```haskell
ghci > "hi" `equalsText` "HI"
True
```

### isEmptyOrWhitespaceText :: Text -> Bool
Check if the `Text` value corresponds to the empty `Text` value after trimming all whitespace from it.

```haskell
ghci > isEmptyOrWhitespaceText ""
True
ghci > isEmptyOrWhitespaceText " "
True
ghci > isEmptyOrWhitespaceText "hi"
False
```

### isEmptyText :: Text -> Bool
Check if the `Text` value corresponds to the empty `Text` value.

```haskell
ghci > isEmptyText ""
True
ghci > isEmptyText "hi"
False
```

### startsWithText :: Text -> Text -> Bool
Check if the first `Text` value starts with the second one.

```haskell
ghci > "hello world" `startsWithText` "hello"
True
```

### startsWithIgnoreCaseText :: Text -> Text -> Bool
Check if the first `Text` value starts with the second one in case-insensitive manner.

```haskell
ghci > "hello world" `startsWithText` "HeLlO"
True
```

### endsWithText :: Text -> Text -> Bool
Check if the first `Text` value ends with the second one.

```haskell
ghci > "hello world" `endsWithText` "world"
True
```

### endsWithIgnoreCaseText :: Text -> Text -> Bool
Check if the first `Text` value ends with the second one in a case-insensitive manner.

```haskell
ghci > "hello world" `endsWithText` "WoRlD"
True
```
## Searching

### indexOfAnyChar :: Text -> [Char] -> Maybe Int
Find the first occurrence of any of the `Char` values in the `Text` value.

```haskell
ghci > "hello world" `indexOfAnyChar` ['E', 'o']
Just 4
```

### indexOfAnyIgnoreCaseChar :: Text -> [Char] -> Maybe Int
Find the first occurrence of any of the `Char` values in the `Text` value in a case-insensitive manner.

```haskell
ghci > "hello world" `indexOfAnyIgnoreCaseChar` ['E', 'o']
Just 1
```

### indexOfChar :: Text -> Char -> Maybe Int
Find the first occurrence of the `Char` value in the `Text` value.

```haskell
ghci > "hello WORLD" `indexOfChar` 'O'
Just 7
```

### indexOfIgnoreCaseChar :: Text -> Char -> Maybe Int
Find the first occurrence of the `Char` value in the `Text` value in a case-insensitive manner.

```haskell
ghci > "hello WORLD" `indexOfIgnoreCaseChar` 'O'
Just 4
```

### indexOfText :: Text -> Text -> Maybe Int
Find the first occurrence of the second argument in the first `Text` value.

```haskell
ghci > "hello WORLD" `indexOfText` "O"
Just 7
```

### indexOfIgnoreCaseText :: Text -> Text -> Maybe Int
Find the first occurrence of the second argument in the first `Text` value in a case-insensitive manner.

```haskell
ghci > "hello WORLD" `indexOfIgnoreCaseText` "O"
Just 4
```

### lastIndexOfAnyChar :: Text -> [Char] -> Maybe Int
Find the last occurrence of any of the `Char` values in the `Text` value.

```haskell
ghci > "hello world" `lastIndexOfAnyChar` ['E', 'o']
Just 7
```

### lastIndexOfAnyIgnoreCaseChar :: Text -> [Char] -> Maybe Int
Find the last occurrence of any of the `Char` values in the `Text` value in a case-insensitive manner.

```haskell
ghci > "hello world" `lastIndexOfAnyIgnoreCaseChar` ['e', 'O']
Just 7
```

### lastIndexOfChar :: Text -> Char -> Maybe Int
Find the last occurrence of the `Char` value in the `Text` value.

```haskell
ghci > "HELLO world" `lastIndexOfChar` 'O'
Just 4
```

### lastIndexOfIgnoreCaseChar :: Text -> Char -> Maybe Int
Find the last occurrence of the `Char` value in the `Text` value in a case-insensitive manner.

```haskell
ghci > "HELLO world" `lastIndexOfIgnoreCaseChar` 'O'
Just 7
```

### lastIndexOfText :: Text -> Text -> Maybe Int
Find the last occurrence of the second argument in the first `Text` value.

```haskell
ghci > "hello world" `lastIndexOfText` "o"
Just 7
```

### lastIndexOfIgnoreCaseText :: Text -> Text -> Maybe Int
Find the last occurrence of the second argument in the first `Text` value in a case-insensitive manner.

```haskell
ghci > "hello WORLD" `lastIndexOfIgnoreCaseText` "O"
Just 7
```

# License
This package is licensed under Apache 2.0. See `LICENSE` file for complete terms on the license.
