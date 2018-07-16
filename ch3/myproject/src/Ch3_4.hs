module Ch3_4 where



---------map-----------
-- *Main Ch3_4 Lib> :t map
-- map :: (a -> b) -> [a] -> [b]

square x = x * x
double x = x + x
m_function1 x = map square x
-- *Main Ch3_4 Lib> :t m_function
-- m_function :: Num b => [b] -> [b]
-- *Main Ch3_4 Lib> m_function [3, 4]
-- [9,16]
-- *Main Ch3_4 Lib> sum (map square [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
-- 385

m_function2 = map (square . double)
-- *Main Ch3_4 Lib> m_function2 [3, 4]
-- [36,64]

m_function3 = concat . map (map square)
m_function4 x = concat ( map (map square) x)
-- *Main Ch3_4 Lib> m_function3 [[1,2,3] , [5,6,7]]
-- [1,4,9,25,36,49]

---------filter-----------
-- *Main Lib> :t filter
-- filter :: (a -> Bool) -> [a] -> [a]

f_function1 x = filter even x
-- *Main Ch3_4 Lib> f_function1 [1,2,3,4,5,6,7,8,9,10]
-- [2,4,6,8,10]
-- *Main Ch3_4 Lib> takeWhile even [1,2,3,4,5,6,7,8,9,10]
-- []

f_function2 x = sum (map square (filter even x))
-- *Main Ch3_4 Lib> f_function2 [1,2,3,4,5,6,7,8,9,10]
-- 220

---------list comprehensions-----------
-- *Main Ch3_4 Lib> [x*2 | x <- [1,2,3]]
--[2,4,6]

c_function1 = [x | x <- [50..100], x `mod` 7 == 3]
-- *Main Ch3_4 Lib> c_function1
-- [52,59,66,73,80,87,94]



-- (Rule 1) : [x | x <- xs] = xs
-- (Rule 2) : [f x | x <- xs] = map f xs
-- (Rule 3) : [x | x <- xs, p x] = [x | x <- filter p x] = filter p xs
-- (Rule 4) : [(x,y) | x <- xs, y <- ys] = concat [[(x,y) | y <- ys] | x <- xs] 

minof xs x = (x == minimum xs)
c_function2 xs = [x | x <- xs,  x == minimum xs]
-- = [x | x <- xs; minof xs x]
-- = [x | x <- filter (minof xs) xs]        (Rule 3)
-- = filter (minof xs) xs                   (Rule 1)


n = 5;
pair i j = (i, j)
mpair i = map (pair i) [i + 1 .. n] 
c_function3 = [(i, j) | i <- [1..n], j <- [i + 1 .. n]]
-- = concat [[(i, j ) | j <- [i + 1 .. n]] | i <- [1 .. n]]         (Rule 4)
-- = concat [map (pair i) [i + 1 .. n] | i <- [1 .. n]]             (Rule 2)
-- = concat (map mpair [1 .. n] )                                   (Rule 2)
