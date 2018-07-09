module Ch2_8 where



-- 함수형언어(haskell)의 특징
-- - 자동 타입 유추(type inference) 
 
myfst :: (a,b) -> a
myfst (x,y) = x

-- :t myfst
-- (a,b) -> a
 
-- 1) Application rule
-- (e1 e2)
-- e1 : 함수
-- e2 : 이 함수의 인자. 
-- 따라서
--  e1 :: a -> b
--  e2 :: a

-- 2) Equality rule
-- (lam x. (1 + x) + g x )  where g z = z
--   1 + x의 문맥으로 x의 타입은 Int 
--   g x의 x도 Int로 동일해야한다.

-- 3) Function rule
--   만일 a -> b = c -> d 이면
--   a = c이고, b = d이다. 

(.) f g x = f (g x)

-- Step1)
-- f :: a -> b
-- g x :: a 

-- g :: c -> d
-- x :: c

-- (.) :: (a -> b) -> (c -> d) -> c -> b

-- Step2)

-- a = d   g x :: a이고, g가 리턴하는 값의 타입이 d이기 때문

-- f :: a -> b
-- g x :: a 

-- g :: c -> a
-- x :: c

-- (.) :: (a -> b) -> (c -> a) -> c -> b

-- :t (.)
-- (.) :: (t1 -> t2) -> (t3 -> t1) -> t3 -> t2

-- f :: (Int, e1) -> (Int, e2) -> Int
f x y = fst x + fst y 

-- Step1)
-- f :: a -> b -> c
-- c = Int
-- fst의 타입은 (d,e) -> d 이므로 
-- a = (d,e) 
-- b = (d,e)
--
-- 그런데 사실 fst의 진짜 타입은 forall d,e. (d,e) -> d. (다형타입, polyrmorphic type)
-- a = (d1,e1) 
-- b = (d2,e2)

-- d1 = Int
-- d3 = Int
 
-- Step2)
-- f :: (Int, e1) -> (Int, e2) -> Int
-- f의 진짜 타입은 forall e1. (Int, e1) -> (Int, e2) -> Int

fix f = f (fix f)

-- Step1)
-- fix :: a -> b
-- f :: a
-- fix f :: b 
-- f :: b -> c 

-- Step2)
-- a = b -> c 
-- b = c
--
-- fix :: (b -> b) -> b

fac :: Int -> Int
fac n | n <= 0    = 1
      | otherwise = n * fac (n-1) 
      
fac' :: (Int -> Int) -> Int -> Int 
fac' f n | n <= 0    = 1
         | otherwise = n * f (n-1) 
        
fixfac = fix fac'  --- fac과 동일한 함수 


-- Exercise 2.8.1

const x y = x 
-- a -> b -> a

subst f g x = f x (g x)
-- subst :: a -> b -> c -> d

-- g x로 부터
-- b = c -> e

-- f x (g x)로 부터
-- a = c -> e -> d

-- 정리하면,
-- subst :: (c -> e -> d) -> (c -> e) -> c -> d 


fixfx f x = f (fixfx f) x 
-- fix :: (a -> b) -> c -> d

-- f의 인자로 (fixfx f)가 주어지기 때문에
-- f의 인자 타입 a와 (fixfx f)의 타입 c -> d가 일치 
-- a = c -> d

-- (f (fixfx f))의 타입이 c -> d이고
-- f의 리턴값의 타입이 b이므로 
-- b = c -> d

-- 정리해보면,
-- fixfx :: ((c -> d) -> (c -> d)) -> c -> d









