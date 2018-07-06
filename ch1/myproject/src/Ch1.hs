module Ch1 where

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

-- In 11th line of Page 6, 
--  _|_   bottom (symbol)
--        undefined value 
-- example:  myundefined 1의 값이 _|_ 
myundefined x = myundefined x 

--  cf. Haskell의 특징 lazy evaluation : _|_을 잘 이용한 프로그래밍 기법 
--       

-- 1.3 Types
-- 타입은 값들의 집합 
-- C언어 타입 : int, char, float, double, T[], *T, struct S, union U
--    int는 정수 값의 집합 { ..., -127, -126, ..., -1, 0, 1, ..., 126, 127, ... }
-- Haskell언어 타입 : 
--  (참고) Haskell 타입 이름은 대문자로 시작
--   Int, Char, Float, Real, 
--   [T]   T타입의 원소를 갖는 리스트 타입 (cf. Java:  List<T> ) 
--       리스트 예: [] 빈 리스트,  [1,2,3]  원소 1,2,3을 포함하는 리스트
--       Haskell String 타입은 [Char] 타입과 동일  
--   (T1, T2, ..., Tk)   for K>=0  튜플 타입 
--       튜플 예: (1, "abc")  (Int, String)
--
-- Strong typing
--   : 프로그램이 일단 타입 검사가 완료되면 프로그램이 잘 동작한다라는 성질

-- 1.4 Functions and Definitions

-- 함수 정의와 함수의 타입
mydouble :: Int -> Int     -- mydouble 함수는 Int 타입의 인자를 받아
                        -- Int 타입의 값을 리턴하는 타입을 갖는다. 
                        -- A :: T 를 읽는 법 "A has type T" 
                        -- 화살표는 함수 타입
mydouble x = x + x

-- 타입 변수와 polymorphic type
myid :: a -> a    --  a를 타입 변수라 부른다
            -- a는 myid를 사용하는 위치마다 달라지는 타입 
            -- 1) myid 123의 경우: Int -> Int
            -- 2) myid "abc"의 경우: String -> String 
            -- 타입 변수가 나타나는 타입을 Polymorphic type

myid x = x   -- myid의 타입은 무엇일까요? 
            -- 임진택: Int -> Int로 가는 함수 타입
            -- 조민우: x의 타입에 따라 myid의 타입이 달라져요.
            -- 김가영: 민우의 말에 동의합니다. 

-- where와 let 

myf (x,y) = (a + 1) * (a + 2)
    where a = (x + y) / 2

    -- where는 지역 변수 선언하는 방법 
    -- cf. myf 함수를 호출하는 방법 : myf (1,2) 

myg (x,y) = 
    let a = (x + y) / 2
    in  (a + 1) * (a + 2)

    -- let도 지역 변수 선언하는 방법 
    -- where vs. let 

-- Currying (커링)  


-- currying을 적용한 (curried) 함수
ourmin x y | x <= y = x    
        | x >= y = y

-- curring을 적용하지 않은 (uncurried) 함수
yourmin (x,y) | x <= y = x
            | x >= y = y


_ = ourmin 1 2
_ = ourmin 1     -- mymin 1의 결과는 함수: 
            --    y를 받아 x와 y의 최소값을 리턴하는 함수 

_ = yourmin (1,2)
-- _ = yourmin (1)   -- 타입 에러 !!

-- Exercises in Page 13
-- 1.4.4
--   one x = 1의 함수 one의 타입?  a -> Int
--   apply f x = f x의 함수 apply의 타입?  (a -> b) -> a -> b
--   compose f g x = (f (g x))의 함수 compose의 타입? 
--     조민우: (a -> b) -> (c -> a) -> c -> b

-- ghci에서 타입을 확인하는 방법
-- > let one x = (1 :: Int)
-- > :t one
-- one :: p -> Int
-- > let apply f x = f x 
-- > :t apply
-- apply :: (t1 -> t2) -> t1 -> t2

-- 1.4.2 
--  (Int -> Int) -> Int의 타입을 갖는 함수?
--       solf1  g = 1     ===> g의 a -> b이 모두 가능하나 a를 Int, b를 Int로 놓을 수도 있음
--       solf2  g = g 1   ===> g의 Int -> b이 모두 가능 b를 Int로 놓을께. 
--       soff3  g = g 1 1  (X)
--       soff4  g = g 1 + 2 ===> g의 타입은 Int -> Int가 유일
--       soff5  g = g (g 1)   ===> Very interesting solutioN!!
--  Int -> (Int -> Int)의 타입을 갖는 함수?
--       solff6 x = one
--       solff7 x = add x
--            where add a b = a + b 
--  (Int -> Int) -> (Int -> Int)의 타입을 갖는 함수?
--       solff8 x = x  ===> x의 a로 모든 타입이 가능 
--       solff8 x = x (x 1)   (X)
--       solff8 x = add (x 1)
--            where add a b = a + b

-- GHCi에서 solff8을 확인해본 결과
-- let add a b = a + b :: Int
-- *Main Lib> :t add
-- add :: Int -> Int -> Int
-- *Main Lib> let f x = add ( x (1 :: Int) )
-- *Main Lib> :t f
-- f :: (Int -> Int) -> Int -> Int

-- (Int -> Int) -> Int -> Int 타입을 읽을 때 right associativity로 해석
-- 맨 상위에 ->가 두 개 나열되는데 오른쪽부터 괄호를 치고 해석
-- (Int -> Int) -> (Int -> Int)


-- 1.5 Skip 
    
    
    
    
    
    
    
    
    
    
    
    