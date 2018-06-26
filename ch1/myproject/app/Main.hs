module Main where

import Lib

main :: IO ()
main = putStrLn "Hello World"

-- Chapter 1. 
-- 1.1 Functional Programming 
-- 1.1.1 Sessions and scripts

square x = x * x

min x y | x <= y = x
        | x >= y = y

mymin x y = if x <= y then x else y 

side = 12

area = square side 

-- Exercise 1.1.1
quad x = square x * square x
-- quad x = square (x * x) 
-- quad x = square (suqare x) 

-- Exercise 1.1.2
max x y | x >= y = x 
        | x <= y = y


-- 1.2 Expressions and values
-- 1.2.1 Reduction
myquad = square . square 

-- (.) f g x = f (g x)
--
-- myquad 3
-- => (square . square) 3
-- => square (square 3)
-- => square 9
-- => 81


