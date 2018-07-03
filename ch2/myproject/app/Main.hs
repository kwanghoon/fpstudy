module Main where

import Lib

main :: IO ()
main = someFunc


-- 2.4 Tuples
-- *Main Lib> (1,2)
-- (1,2)
-- *Main Lib> (1,'2')
-- (1,'2')
-- *Main Lib> (1,'2',"2")
-- (1,'2',"2")
-- *Main Lib> [1,'2']

-- <interactive>:7:2: error:
--     ? No instance for (Num Char) arising from the literal ‘1’
--     ? In the expression: 1
--       In the expression: [1, '2']
--       In an equation for ‘it’: it = [1, '2']

-- *Main Lib> ()
-- ()
-- *Main Lib> fst (1,2)
-- 1
-- *Main Lib> snd (1,2)
-- 2
-- *Main Lib> :t (1,2)
-- (1,2) :: (Num b, Num a) => (a, b)
-- *Main Lib> :t (1::Int, 2::Int)
-- (1::Int, 2::Int) :: (Int, Int)
-- *Main Lib> fst (1,'2')
-- 1
-- *Main Lib> :t fst :: (a, b) ->  a
-- *Main Lib> :t fst
-- fst :: (a, b) -> a
-- *Main Lib> :t snd
-- snd :: (a, b) -> b
-- *Main Lib> fst (1,2,3)

-- <interactive>:16:5: error:
--     ? Couldn't match expected type ‘(a, b0)’
--                   with actual type ‘(Integer, Integer, Integer)’
--     ? In the first argument of ‘fst’, namely ‘(1, 2, 3)’
--       In the expression: fst (1, 2, 3)
--       In an equation for ‘it’: it = fst (1, 2, 3)
--     ? Relevant bindings include it :: a (bound at <interactive>:16:1)
-- *Main Lib> let fst3 (x,y,z) = x
-- *Main Lib> fst3 (1,2,3)
-- 1
-- *Main Lib> :t fst3
-- fst3 :: (a, b, c) -> a
-- *Main Lib>

-- a x^2 + b x + c = 0의 방정식의 해를 구하시오. 
-- 

roots (a,b,c) | d>0 = (1,1)
              | otherwise = error "방정식의 해가 존재하지 않아요."
    where d = 0

-- gcd x y = gcd x y (min x y)

-- gcd' x y 1 = 1
-- gcd' x y n = 
--     if x `mod` n == 0 && y `mod` n == 0 then n 
--     else gcd' x y (n-1)

-- gcd 12 8
-- = gcd' 12 8 8
-- = gcd' 12 8 7 
-- = gcd' 12 8 6 
-- = gcd' 12 8 5
-- = gcd' 12 8 4 
-- = 4

norm (x,y) 
    | y /= 0 = (u `div` d, v `div` d)
        where sign x | x > 0  = 1
                     | x == 0 = 0


                     | x < 0  = -1
              u = sign y * x
              v = abs y
              d = gcd (abs u) v
            
radd (x,y) (u,v) = norm (x * v + u * y, y * v)

