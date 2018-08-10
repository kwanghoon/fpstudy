module Ch3_3 where 
import Data.List

--x : a::Int,Char...
--xs : [a, b]
--xss : [[a ,b],[c, d]]

a = [1,2,3,4]
b = [8,6,4]
c = [10,11,12,13,14]

-- 1) ++, concat, --
-- a ++ b       --> [1,2,3,4,8,6,4]
-- concat [a,b] --> [1,2,3,4,8,6,4]
-- a -- b       --> 

-- 2) head/tail, init/last
-- head a       --> 1
-- tail a       --> [2,3,4]
-- init a       --> [1,2,3]
-- last a       --> 4

-- 3) revese, length, !!
-- reverse a    --> [4,3,2,1]
-- length a     --> 4
-- a !! 2       --> 2

-- 4) take/drop, takeWhile/dropWhile
-- take 2 a         --> [1,2]
-- drop 2 a         --> [3,4]
-- takeWhile (<3) a --> [1,2]
-- dropWhile (<3) a --> [3,4]

-- 5) zip/zip3..7, zipWith/zipWith3..7 
-- zip a b          --> [(1,8),(2,6),(3,4)]
-- zip3 a b c       --> [(1,8,10),(2,6,11),(3,4,12)]
-- zipWith (*) a b  --> [8,12,12]
multiply3 x y z = x * y * z
-- zipWith3 multiply3 a b c --> [80,132,144]

--3.3.9 [1,2,3] --> [(1,2,3),(2,3,4)]
trips xs = zip3 xs (drop 1 xs) (drop 2 xs)
            -- zip3 [1,2,3,4] [2,3,4] [3,4]
            -- [(1,2,3),(2,3,4)]

--3.3.10 [1,9,8,4] --> [1,8,9,4]
xs' = [1,9,8,4]
odd' xs = [x | x <- xs, odd x]
even' xs = [x | x <- xs, even x]
riffle xs = concat [[x,y] | (x,y) <- zip (odd' xs) (even' xs)]
            --concat [[x,y] | zip [1,9] [8,4]]
            --concat [[x,y] | (1,8), (9,4)]
            --concat [[1,8],[9,4]]