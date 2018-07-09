module Ch3_2 where

    import Lib
    import Data.Char
    import Prelude
    
    
    -------3.2 List comprehensions
    
    --[<expression> | <qualifier> , ... , <qualifier>]
    
    --ex1) [ x | x <- [1..10]]
    -- ->  [1,2,3,4,5,6,7,8,9,10]
    
    --ex2) [ x | x <- [1..10] , even x ]  // even : 짝수 odd : 홀수
    -- ->  [2,4,6,8,10]
    
    --ex3) [ x*x | x <- [1..10], even x]
    -- ->  [4,16,36,64,100]
    
    ----------------------------------
    
    -- tuple in List
    
    --ex4) [(a,b) | a <- [1..3] , b <- [1..2]]
    -- ->  [(1,1),(1,2),(2,1),(2,2),(3,1),(3,2)]
    
    ---- Check This!
    -- later generators can depend on 
    -- the variables introduced by earier ones!
    
    --ex5) [(i, j) | i <- [1..4], j <- [i+1..4]]--> j -> i+1 i+2 ... 4
    -- ->  [(1,2),(1,3),(1,4),(2,3),(2,4),(3,4)]
    -----  i = 1 --> j = 2, 3 ,4
    -----  i = 2 --> j = 3, 4
    -----  i = 3 --> j = 4
    
    --ex6) [(i, j) | i <- [1..4], even i, j <- [i+1..4] , odd j]
    -- ->  [(2,3)]
    
    pairs = [(i,j) | i <- [1..2], j <- [1..3]]
    
    --ex7) [(i, j) | (i,j) <- pairs]
    -- ->  [(1,1),(1,2),(1,3),(2,1),(2,2),(2,3)]
    --ex8) [(i, j) | (i,j) <- pairs, even i]
    -- ->  [(2,1),(2,2),(2,3)]
    
    ---finally,  expression does not need to use variable
    
    --ex9) [3 | x <- [1..3]]
    -- ->  [3,3,3]
    --ex10)[x | x <- [1..3], y <- [1..2]]
    -- ->  [1,1,2,2,3,3]
    
    spaces x = [' ' | i <- [1..x]]
    
    divisors x = [d | d <- [1..x], x `mod` d == 0]
    
    --- gcd a b = max[d | d <- divisors a, b `mod` d == 0]
    prime :: Int -> Bool
    prime x = (divisors x == [1,x]) 
    
    intsqrt x = g x n 
            where g x n | x < n^2 = g x (n-1)
                        | otherwise = n     
                  n = x       
    
    
    ----- prime을 구하는 더 효율적인 공식
    --prime x = x > 1 && ([d | d <-[1.. intsqrt x], x `mod` d == 0] == [])
    
    ----- Pythagorean triads
    
    triads n = [(x, y, z) | x<- [1..n], y <- [1..n], z <- [1..n], x^2 + y^2 == z^2]
    
    ---exercise
    
    --3.2.1   [j | i<- [1, -1, 2, -2] , i > 0 , j <- [ 1..i]]
    --        [1,1,2]
    
    --3.2.2   [x | x <- xs , y <- ys] == [x | y <- ys, x <- xs] ??
    --        why??
    
    
    --3.2.3 --
    --3.2.4 --
    --3.2.5 --
    --3.2.6 exp x n = product[x | a <- [1..n]]  --sum : list 내의 모든 원소를 더한다
                                                --product : list 내의 모든 원소를 곱한다.
    --3.2.7
    --3.2.8
    --3.2.9
    --3.2.10 Show that if n has a divisor in the range 1 < d < n, then it has one in the range 1 < d < sqrt n 
    
    --proof x = [ d | d <- divisors x , d>1 , d <= intsqrt x]
    
    
    
    