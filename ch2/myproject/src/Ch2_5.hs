module Ch2_5 where

-- 2.5 Patterns

-- cond p x y | p == True = x
--            | p == False = y
cond True x y = x
cond False x y = y
-- cond True "abc" "def"
-- cond False 123 456

-- permute x | x == 0 = 1
--           | x == 1 = 2
--           | x == 2 = 0
permute 0 = 1
permute 1 = 2
permute 2 = 0
permute n = error ("permute error: " ++ show n)

-- pred n | n == 0 = 0
--        | otherwise = n - 1
pred 0 = 0
pred n = n - 1

-- count n | n == 0 = 0
--         | n == 1 = 1
--         | otherwise = 2
count 0 = 0
count 1 = 1
count n = n - 2

-- exercise 2.5.2
-- mypred n | n == 0 = 0
--          | n > 0 = n - 1
mypred 0 = 0
mypred n = n - 1

myTuple (x, (y, True)) = 1
yourTuple t = if snd (snd t) == True then 1
              else error("yourTuple error: " ++ show t)