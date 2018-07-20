module Ch3_5 where

-- 3.5 foldr

-- list의 재귀의 패턴을 표현
-- f [] = v
-- f (n:ns) = n pred f ns
-- pred는 인자가 두 개인 모든 함수가 될 수 있음

-- fold op는 foldr, foldl이 존재함
-- foldr란 fold right라는 뜻으로 list의 우측부터 연산한다는 뜻

-- sum function 
-- v = 0 , pred = +
-- sum' :: Num a => [a] -> a 
-- -- sum' [] = 0
-- -- sum' (n:ns) = n + sum' ns
-- sum' = foldr (+) 0

-- product function
-- v = 1 , pred = *
-- product :: Num a => [a] -> a
-- product [] = 1
-- product (n:ns) = n * product ns

-- and function
-- v = True, pred = &&
-- and :: [Bool] -> Bool
-- and [] = True
-- and (n:ns) = n && and ns

-- function을 foldr형식으로 정의 시
-- f = foldr pred v
-- pred는 연산자, v는 초깃값 (항등원 역할)

-- sum , product, or, and function을 foldr형식으로 정의
-- sum = foldr (+) 0
-- product = foldr (*) 1
-- or = foldr (||) False
-- and = foldr (&&) True


-- (??) foldr :: (a -> b-> b) -> b -> [a] -> b
-- a -> b -> b 
-- ex ) 2 * 3.0 = 6.0
-- foldr f v [] = []

-- sum [1,2,3]을 foldr로 표현하기
-- sum [1,2,3]
-- = foldr (+) 0 [1,2,3]
-- = foldr (+) 0 (1:(2:(3:[])))
-- = 1+(2+(3+0))
-- = 6
-- = foldl (+) 0 [1,2,3]
-- = ((0+1)+2)+3

-- length'를 foldr 형식으로 변경하기
-- length [1,2,3] // 3
-- length' :: [a] -> Int
-- -- length' [] = 0 
-- -- length' (n:ns) = 1 + length' ns
-- --------------------------------------
-- length' = foldl f 0
--         where f = \n _  -> n + 1
--         = foldr f 0
--         where f = \_ n -> 1 + n

-- 익명 함수는 리스트 원소와 그 길이를 받아 다음 함수 계산에 인자로 넘겨줌

-- foldr f v (x:xs) = f x (foldr f v xs)

-- length, reverse function 정의
-- length' :: [a] -> Int
-- length' = foldr f 0
--             where f = \x n -> n + 1

-- reverse' :: [a] -> [a]
-- reverse' [] = []
-- reverse' (x:xs) = reverse' xs ++ [x]
-- reverse' zs = foldr f [] zs
--         where f = \x xs -> xs ++ [x]
-- reverse [1,2,3] = foldr f [1,2,3] = foldr f 1:(2:(3:[]))

-- * 함수 정의 시 타입 지정해놓지 않았을 때 에러 뜨는 경우와 아닌 경우 (람다식)


 
    
-- foldl이용한 pack function
-- pack :: Num a => [a] -> a
-- pack xs = foldl f 0 xs
--          where f = \n x -> 10 * n + x

-- takeWhile은 function value이 거짓이 나오기전까지의 원소만 돌려줌

-- takeWhile function을 foldr을 사용하여 변경
-- takeWhile' :: (a -> Bool) -> [a] -> [a]
-- takeWhile' p [] = []
-- takeWhile' p (x:xs) | p x = x : takeWhile' p xs
--                     | otherwise = []
--------------------------------------------------------------
-- takeWhile' :: (a -> Bool) -> [a] -> [a]
-- takeWhile' p = foldr f []
--             where f = \x xs -> if (p x) then (x : xs) else [] 
 
-- takeWhile isAlpha "abc def"
-- -- "abc"

-- foldl은 sum,product에 유리하고, foldr은 and,concat,or등에 유리

-- foldr과 foldl이 같다는 것을 증명

-- prefix :: [a] -> [a]
-- prefix [] = []
-- prefix (x:xs) = [x] ++ xs 

-- reverse = foldl prefix [] 
--         where prefix xs x = [x] ++ xs 

-- 3.5.1 law

-- 1th 이원법칙
-- foldr, foldl의 결과는 같다.
-- : 2th 이원법칙의 특별한 경우 (+,-,*)

-- 2th 이원법칙
-- reverse' :: [a] -> [a]
-- reverse' [] = []
-- reverse' (n:ns) = reverse ns ++ [n]
-- reverse' = foldr f []
--          where f = \x xs -> xs ++ [x]
-- reverse' = foldl f []
--          where f = \xs x -> [x] ++ xs
-- f는 다르지만, 결과는 같음

-- 3th 이원법칙 
-- 증명
-- foldr (pred) a xs = foldl (~pred) a (reverse xs) 
-- xs = [x1,x2,x3,x4]
-- foldr (pred) a [x1,x2,x3,x4] = foldl (pred) [x4,x3,x2,x1] a
-- x1 (pred)(x2 (pred)(x3 (pred) (x4 (pred) a)))
-- (((a (pred) x4) (pred) x3) (pred) x2) (pred) x1
-- 증명 완료 

-- (:) 1 [2,3,4,5] = [1,2,3,4,5]
-- cons :: a -> [a] -> [a]

-- 3.5.2 fold over non-empty list

-- 일반적으로 fold operation은
-- foldr f v [x1..xn] 이나 foldl f v [x1..xn]의 format
-- but max같이 항등원인 초깃값이 없는 f도 존재
-- foldll, foldrl :: (a -> a -> a) -> [a] -> a (v가 존재하지 않음)
-- foldr1 f ns = foldr f (head ns) (tail ns) 


-- 3.5.3 Scan
-- scanl, scanr 정의
-- scanl (+) 0 [1..5]
-- scanl (*) 1 [1..5] 

-- > map fact [0..5]와 동일
-- fact :: Int -> Int
-- fact 0 = 1
-- fact n = n * fact (n-1)

-- -- exercise 1 
-- all' :: (a -> Bool) -> [a] -> Bool
-- -- all' f [] = True
-- -- all' f (x:xs) | f x = True && (all' f xs)
-- --               | otherwise = False
-- all' p = foldr f True
--      where f = \x xs -> (p x) && xs

-- exercise 4

-- exercise 5

