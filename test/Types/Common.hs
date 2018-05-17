module Types.Common
  ( genDecimalDigit
  , genDecimalDigits
  , genDecimalDigitNoZero
  , genHeXaDeCiMaLDigit
  , genHeXaDeCiMaLDigitNoZero
  , genNonEmptyDecimalDigit
  , genText
  , genWhitespace
  ) where


import           Data.List.NonEmpty          (NonEmpty)
import           Data.Semigroup              ((<>))
import           Data.Text                   (Text)

import           Hedgehog
import qualified Hedgehog.Gen                as Gen
import qualified Hedgehog.Range              as Range

import           Data.Digit                  (Digit)
import qualified Data.Digit                  as D

import           Waargonaut.Types.Whitespace (Whitespace (..))

genDecimalDigit :: Gen Digit
genDecimalDigit = Gen.element decimalDigit

genHeXaDeCiMaLDigit :: Gen Digit
genHeXaDeCiMaLDigit = Gen.element hExAdEcImAlDigit

decimalDigit :: [Digit]
decimalDigit =
  [ D.Digit0
  , D.Digit1
  , D.Digit2
  , D.Digit3
  , D.Digit4
  , D.Digit5
  , D.Digit6
  , D.Digit7
  , D.Digit8
  , D.Digit9
  ]

hExAdEcImAlDigit :: [Digit]
hExAdEcImAlDigit = decimalDigit <>
  [ D.Digita
  , D.Digitb
  , D.Digitc
  , D.Digitd
  , D.Digite
  , D.Digitf
  , D.DigitA
  , D.DigitB
  , D.DigitC
  , D.DigitD
  , D.DigitE
  , D.DigitF
  ]

genDecimalDigitNoZero :: Gen Digit
genDecimalDigitNoZero = Gen.filter (/= D.Digit0) genDecimalDigit

genHeXaDeCiMaLDigitNoZero :: Gen Digit
genHeXaDeCiMaLDigitNoZero = Gen.filter (/= D.Digit0) genHeXaDeCiMaLDigit

genDecimalDigits :: Gen [Digit]
genDecimalDigits = Gen.list (Range.linear 1 10) genDecimalDigit

genNonEmptyDecimalDigit :: Gen (NonEmpty Digit)
genNonEmptyDecimalDigit = Gen.nonEmpty (Range.linear 1 10) genDecimalDigit

genWhitespace :: Gen Whitespace
genWhitespace = Gen.element
  [ Space
  , HorizontalTab
  , LineFeed
  , NewLine
  , CarriageReturn
  ]

genText :: Gen Text
genText = Gen.text ( Range.linear 0 100 ) Gen.unicodeAll
