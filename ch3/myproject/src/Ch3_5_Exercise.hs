module Ch3_5_Exercise where

-- Exercise 3.5.4
-- isort [2,1,4,3] ==> [1,2,3,4]

insert x xs = takeWhile (<= x) xs ++ [x] ++ dropWhile (<= x) xs

-- 
isort xs = foldl f [] xs 
    where f xs x = insert x xs 

isortR xs = foldr insert [] xs


-- Exercise 3.5.5
-- 
remdups xs = foldr f [] xs
    where f y []     = [y] 
          f y (z:zs) = if y == z then z:zs else y:z:zs    

remdupsL xs = foldl f [] xs
    where f zs y = if last zs == y then zs else zs ++ [y]

        -- foldl의 경우 list pattern을 사용하는 것이 부자연스러움
        --   f [] y = [y]
        --   f (z:zs) y = 

-- remdups [1,2,2,3,3,3,1,1]
-- [1,2,3,1]


-- Exercse 3.5.9
calcE n = foldl (+) 0 (scanl (/) 1 [1..n])

-- []:xs = xs        (x)
-- []:xs = [[],xs]   (x)
--   cf. []:xs = [[]] ++ xs   (o)
-- > []:[[1],[2]]
-- [[],[1],[2]]
-- > [[]]++[[1],[2]]
-- [[],[1],[2]]

-- xs:[] = xs (x)
-- cf. xs:[] = [xs]   (o)

