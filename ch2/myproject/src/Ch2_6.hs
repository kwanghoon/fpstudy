module Ch2_6 where

-- 2.6.1 Functional composition
function1 x = x * x
function2 x = x + x
function3 x = x + x

sol1 f g x = f (g x)
-- sol1 functionl function2 5 --> 100
sol2 f g x = (f . g) x
-- sol2 functionl function2 5 --> 100
-- *Main Lib> :t (.)
-- (.) :: (b -> c) -> (a -> b) -> a -> c

soln1 x = function1 (function2 (function3 x)) 
-- soln1 5 --> 400
soln2 = function1 . function2 . function3 
-- soln2 5 --> 400

-- *Main Lib> :t soln1
-- soln1 :: Num a => a -> a
-- *Main Lib> :t soln2
-- soln2 :: Integer -> Integer

-- 2.6.2 Operators
addd x y = x + y
--addd 2 3   --> 5
--2 `addd` 3 --> 5


-- 2.6.4 Strict and non-strict functions
three x = 3
-- three 1/0   --> Infinity
-- (three 1)/0와 동일
-- three (1/0) --> 3
-- three 3+5   --> 8
infin x = x
-- infin (1/0) --> Infinity

--if fㅗ = ㅗ then strict


-- strict < non-strict
-- ex) 3 + three (1/0)  --> 6
--     3 + infin (1/0)  --> Infinity

t_recip x | x==0 = 0
          | otherwise = (1/x)


cond p x y | p = x
           | otherwise = y

recip x = cond (x==0) 0 (1/x)