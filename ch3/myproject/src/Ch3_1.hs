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