-- Destructuring tuples in Elm using let-in expressions
aTuple = (60,65,71,75,90)

-- example 1
let \
  (a,b,c,d,e) = aTuple \
in \
  a + b + c + d + e


-- example 2
let \
  (a,b,c,d,e) = aTuple \
in \
  (a + b + c + d + e) / 5
  

-- example 3
let \
  (a,b,c,d,e) = aTuple \
in \
  (a+b+c) / 3
  
  
-- example 4
aTupleOfStrings = ("Hello", "Big", "Wild", "Funny", "World")


-- example 5, print out "Hello World"
let \
  (a,_,_,_,e) = aTupleOfStrings \
in \
  a ++ e


-- example 6, replace one-letter-variables with something more meaningful
let \
  (greeting,_,_,_,planetDescription) = aTupleOfStrings \
in \
  greeting ++ planetDescription


-- DESTRUCTURING TUPLES IN ELM USING CASE-OF EXPRESSIONS

module Main exposing (main)

import Html exposing (Html, text)

greeting = ("Hello", "World")
-- greeting = ("Howdy", "World")
-- greeting = ("Howdy", "Earth")

main : Html msg
main =
    case greeting of 
        ("Hello", "World") ->
            text "Tuple contained: Hello, World!"
            
        ("Hello", _) ->
            text "Tuple contained: Hello "

        (_, "World") ->
            text "Tuple contained: World!"

        (_, _) ->
            text "There were neither 'Hello' nor 'World' in the greeting Tuple"


-- BUILDING A FIZZBUZZ APP USING TUPLE DESTRUCTURING INSIDE OF A CASE-OF EXPRESSION
module Main exposing (main)

import Html exposing (..)

n = 100
modulusTest = (n % 3, n % 5)

main : Html msg
main = 
  text <| let fizzBuzz n = 
              case modulusTest of
                (0, 0) -> "fizzBuzz"
                (0, _) -> "fizz"
                (_, 0) -> "buzz"
                (_,_) -> toString n
          in fizzBuzz n
{-
-- We could have written the main function like this:
main = 
  text (let fizzBuzz n = 
              case modulusTest of
                (0, 0) -> "fizzBuzz"
                (0, _) -> "buzz"
                (_, 0) -> "fizz"
                (_,_) -> toString n
        in fizzBuzz n)
-}

-- PRINTING OUT THREES AND SEVENS
module Main exposing (main)

import Html exposing (..)

n = 70
modulusTest = (n % 3, n % 7)

main : Html msg
main = 
  text (let fizzBuzz n = 
              case modulusTest of
                (0, 0) -> "Divisible by 21, seven, and three"
                (0, _) -> "Divisible by three"
                (_, 0) -> "Divisible by seven"
                (_,_) -> toString n
        in fizzBuzz n)



-- DESTRUCTURING NESTED TUPLES USING LET-IN EXPRESSIONS

-- example 1
nestedTuples = (1, 2, 3, (5, 10, 15, (100, 50, 0)))

-- example 2
let \
  (a, b, c, (d, e, f, (g, h, i))) = nestedTuples \
in \
  i

  
-- example 3: destructuring values on the fly, inside the let-in statement
module Main exposing (main)

import Html exposing (..)

main : Html msg
main = 
  text (toString (
              let 
                  (a,b,c,(d,e,f,(g,h,i))) = (1, 2, 3, (5, 10, 15, (100, 50, 0)))
              in
                  i
              ))

-- example 4: using the underscore when suitable
module Main exposing (main)

import Html exposing (..)

main : Html msg
main = 
  text (toString (
              let 
                  (_,_,c,(_,_,f,(_,_,i))) = (1, 2, 3, (5, 10, 15, (100, 50, 0)))
              in
                  i
              ))


-- DESTRUCTURING RECORDS IN ELM USING LET-IN EXPRESSIONS
module Main exposing (main)

import Html exposing (..)

raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }

averageRunnerTime record =
    let 
        {first, second, third, fourth, fifth} = record
    in
        (first + second + third + fourth + fifth) / 5
        
main : Html msg
main = 
  text (toString (
              averageRunnerTime raceTimes
              ))


-- DESTRUCTURING RECORDS ON THE FLY
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }

{ fifth } = raceTimes

-- destructure the time of the fifth runner
module Main exposing (main)

import Html exposing (..)

extractorFunction { fifth } =
    fifth
    
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }
fifth = raceTimes

main : Html msg
main = 
  text (toString (
              extractorFunction raceTimes
              ))


-- Doing it without the extractorFunction, attempt one (compiles, but does not do what we want):
module Main exposing (main)

import Html exposing (..)

    
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }
fifth = raceTimes

main : Html msg
main = 
  text (toString (
              fifth
              ))


-- Doing it without the extractorFunction (this time, successfully)
module Main exposing (main)

import Html exposing (..)

    
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }
fifth = raceTimes

main : Html msg
main = 
  text (toString (
              raceTimes.fifth
              ))

-- Deconstructing only 2 values (code fails to compile!)
module Main exposing (main)

import Html exposing (..)

extractorFunction { first, fifth } =
    first, fifth
    
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }
{first, fifth} = raceTimes

main : Html msg
main = 
  text (toString (
              extractorFunction raceTimes
              ))


-- Deconstructing only 2 values (code compiles successfully)
module Main exposing (main)

import Html exposing (..)

extractorFunction { first, fifth } =
    (first, fifth)
    
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }
{first, fifth} = raceTimes

main : Html msg
main = 
  text (toString (
              extractorFunction raceTimes
              ))


-- Printing out values as strings (alternative approach)
module Main exposing (main)

import Html exposing (..)

    
raceTimes = { first = 60, second = 65, third = 71, fourth = 75, fifth = 90 }


main : Html msg
main = 
  text <|
      toString (raceTimes.first)
      ++ ", " 
      ++ toString (raceTimes.fifth)



-- Improving the Elm architecture by adding effects
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


-- UNDERSTANDING PARTIAL APPLICATION
concatTwoWords wordOne wordTwo = wordOne ++ " " ++ wordTwo

concatTwoWords "User" "Experience"

-- A TINY PROGRAM TO RUN IN ELM
module Main exposing (main)

import Html exposing (Html, text)

concatTwoWords : String -> String -> String
concatTwoWords wordOne wordTwo = wordOne ++ " " ++ wordTwo

main : Html msg
main =
    text (concatTwoWords "User" "Experience")


-- PASSING ONLY ONE ARGUMENT TO concatTwoWords function throws an error:
module Main exposing (main)

import Html exposing (Html, text)

concatTwoWords : String -> String -> String
concatTwoWords wordOne wordTwo = wordOne ++ " " ++ wordTwo

main : Html msg
main =
    text (concatTwoWords "User")


-- SUCCESSFULLY COMPILING WITH partiallyApply
module Main exposing (main)

import Html exposing (Html, text)

wordOne = "User"
wordTwo = "Experience"

concatTwoWords : String -> String -> String
concatTwoWords wordOne wordTwo = wordOne ++ " " ++ wordTwo

partiallyApply = concatTwoWords wordOne
partiallyApplyAgain = partiallyApply wordTwo

main : Html msg
main =
    text (partiallyApplyAgain)
