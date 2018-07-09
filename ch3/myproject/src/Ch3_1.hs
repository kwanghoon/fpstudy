module Ch3_1 where

-- 3.1 List notation
-- list must have the same type

numList1 = [1, 2, 3]
-- *Ch3_1> [1, 2, 3]
-- [1,2,3]

strList1 = ["h", "e", "l", "l", "o"]
-- *Ch3_1> ["h", "e", "l", "l", "o"]
-- ["h","e","l","l","o"]

charList = ['a', 'b', 'c', 'd', 'e', 'f']
-- *Ch3_1> ['a','b', 'c', 'd', 'e', 'f']
-- "abcdef"

opList = [(+), (-), (*)]
-- *Main Ch3_1 Lib> :t opList
-- opList :: [Integer -> Integer -> Integer]  

strList2 = ["abc", [], "ghi"]
-- *Ch3_1> ["abc", [], "ghi"]
-- ["abc","","ghi"]

numList2 = [1 .. 5]
-- *Ch3_1> [1 .. 5]
-- [1,2,3,4,5]

numList3 = [1, 3 .. 11]
-- *Ch3_1> [1, 3 .. 11]
-- [1,3,5,7,9,11]

bool1 = [1, 1] == [1]
-- *Ch3_1> [1, 1] == [1]
-- False

bool2 = [1, 2, 3] == [3, 2, 1]
-- *Ch3_1> [1, 2, 3] == [3, 2, 1]
-- False

bool3 = [1 .. 5] == [1, 2 .. 5]
-- *Ch3_1> [1 .. 5] == [1, 2 .. 5]
-- True

--chapter 2.8 exercise
-- subst f g x = f x (g x)
-- subst :: a -> b -> c -> d
-- f :: (c -> e) -> d
-- g :: c -> e
-- x :: c

-- a = e -> d
-- b = c -> e
-- c = c

-- subst :: (c -> e -> d) -> (c -> e) -> c -> d

trips [] = []
trips [_] = []
trips [_, _] = []
trips xs =  let list3 = take 3 xs
                tup = (list3 !! 0, list3 !! 1, list3 !! 2)
            in [tup] ++ trips (tail xs)

-- trips
-- *Ch3_1> trips []
-- []
-- *Ch3_1> trips [1]
-- []
-- *Ch3_1> trips [1, 2]
-- []
-- *Ch3_1> trips [1, 2, 3]
-- [(1,2,3)]
-- *Ch3_1> trips [1, 2, 3, 4, 5]
-- [(1,2,3),(2,3,4),(3,4,5)]