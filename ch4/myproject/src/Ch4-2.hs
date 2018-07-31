module Ch4_2 where

      import Lib
      import Data.Char
      import Prelude
      
      --가변 길이 정수의 연산
      --Chap 2에서 본 것과 같이 Haskell에는 제한된 범위 내의 숫자에 대한 연산들이 들어있다
      --그렇다면 제한된 범위를 벗어나는 숫자의 연산은 어떻게 하는 것이 좋을까
      --이 챕터에서는 그 방법에 대해 소개한다.
      
      --Idea : 숫자를 List로 표현한다.
      -- +++ 
      -- b(base)보다 작은 숫자의 리스트로 표현하기
      -- Int x == [X(n-1), X(n-2), .. , X(0)]
      -- 각각의 X 에 대해 0 < X < b
      -- base를 정할 때 요구되는 것 : b^2 <= maxint --> maxint는 하스켈에 내장된 연산으로 
      --                                              다룰 수 있는 최대의 정수
      
      --ex) 123456789 -> [1,2345,6789] --> 1*10000^2 + 2345*10000^1 + 6789*10000^0
      --    100020003 -> [1,2,3]       --> 1*10000^2 + 2*10000^1 + 3*10000^0
      
      
      --Vint로 표현된 리스트를 보고 Base를 추정할 수 있다. 정답은 아니다 ex) [1,2,3] b = 100 --> 10203
      --                                                                         b = 10  --> 123
      -- [1,23,45]  -> b = 100
      -- [12,34,56] -> b = 100
      -- [1,234,567]-> b = 1000
      
      type Bigit = Integer
      type Vint = [Bigit]
      
      getB x y | x^2 >= y  = x`div`10
               | otherwise = getB (x*10) y
      getb n xs | n > maximum xs = n `div` 10
                | otherwise = getb (n*10) xs
      getB' xs = getb 1 xs
      
      
      --
      vint:: Integer -> (Vint, Integer)
      vint x = ([(x `div` b^n `mod` b )| b <- [getB 1 x], n <- [2,1,0]], (getB 10 x))
      
      
      strep xs | ys == [] = [0]
               | otherwise = ys
                  where ys = dropWhile ( == 0 ) xs
      
      copy x n = [x | j <- [1..n]]
      
      align xs ys | n > 0 = (copy 0 n ++ xs, ys)
                  | otherwise = (xs, copy 0 (-n) ++ ys )
                  where n = length ys - length xs
      
      vcompare op xs ys = op us vs where (us, vs) = align xs ys
      
      veq = vcompare (==)
      vleq = vcompare (<=)
      vless= vcompare (<)
      
      carry x (c:xs) = ((x+c) `div` b):((x+c) `mod` b) : xs
                          where b = 10        
      --ex) b = 10 , [7,3,7] + [4,6,9] = ?
      --           ->[11,9,16]  --> b = 10 에 맞지 않음
      -- > normalise
      
      --foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
      norm = strep . foldr carry [0] 
      
      -- > streap ( carry 11 ( carry 9 ( carry 16 [0] )))
      -- > streap ( carry 11 ( carry 9 [1,6])))
      -- > streap ( carry 11 [1, 0, 6])
      -- > streap ( [1,2,0,6])
      -- > [11,9,16] = 11*10^2 + 9*10^1 + 16*10^0 
      --             = 1100 + 90 + 16
      --             = 1206
      -- > [1,2,0,6] = 
      
      zipwith op (x,y) = zipWith op x y
      
      vadd xs ys = norm (zipwith (+) (align xs ys))
      vsub xs ys = norm (zipwith (-) (align xs ys))
      
      -- vsub [1,0,6][3,7,5]
      -- > [-1,7,3,1]
      
      negative xs = head xs < 0
      negate' = norm . map neg
      neg x = -x;
      -- negate' [-1,7,3,1]
      -- ->
      -- norm [1, -7, -3, -1]
      -- [2,6,9]
      
      
      --곱셈 --> 자릿수마다 곱해서 더해준다.
      psums xs ys = map (bmul xs) ys 
      bmul xs y = norm (map (*y) xs) 
      
      (+++) xs ys = vadd (xs ++ [0]) ys 
      
      vmul xs ys = foldl1 (+++) (psums xs ys)
      
      --foldl1 = fold의 변종, Foldable t 의 첫번째원소를 자동으로 취하여 fold
      
      --나눗셈 , bstep으로 들어가기 위한 조건이 있다.
      -- if( #xs = #ys) 이면 ys > xs/2 이어야 bstep이 성립한다.
      divalg xs ys = scanl (dstep ys) (0, take m xs) (drop m xs)
                   where m = length ys - 1 
      -- :t scanl :: (b -> a -> b) -> b -> [a] -> [b]
      -- divalg [2,9,2,0] [2,9]
                  -- scanl ( dstep [2,9] ) ( 0, [2] ) ( [9,2,0] )
                  -- in dstep, xs == rs ++ [x]
      -- ==> in line 112, scanl set (0, [2]) for first element   (1)
      -- next,
      -- ==2 dstep [2,9] (0, [2]) 9
      -- ==> bstep -> (1, [0])                                    (2)
      -- ==3 dstep [2,9] (1, [0]) 2
      -- ==> astep -> (0, [0, 2])                                 (3)
      -- ==4 dstep [2,9] (0, [2]) 0 
      -- ==> bstep -> (0, [2,0])                                  (4)
      -- finally,  [(0,[2]),(1,[0]),(0,[0,2]),(0,[2,0])]
      -- 2920 / 29 = 100 ... 20
      -- divalg [2,9,2,0] [2,9]
      -- [(0,[2]),(1,[0]),(0,[0,2]),(0,[2,0])]
      
      dstep ys (q, rs) x  | length xs < length ys = astep xs ys
                          | length xs == length ys = bstep' xs ys
                          | length xs == (length ys + 1) = cstep xs ys
                          where xs = rs ++ [x] 
      --xs와 ys의 길이를 비교하고 그 결과에 따라 다른 연산을 한다.
      
      -- xs < ys
      astep xs ys = (0, xs)
      
      
      -- xs = ys
      bstep xs ys | negative zs = (0, xs)
                  | otherwise = (1,zs)
                  where zs = vsub xs ys 
                  -- where zs | vless (vsub xs ys) ys = vsub xs ys
                  -- |otherwise = vsub (vsub xs ys) ys
      
      -- bstep idea 추가.
      bstep' xs ys = inb xs ys 0
      --inb::[Integer]->[Integer]->Integer->(Integer, [Integer])
      inb xs ys z | negative (vsub xs ys) = (z, xs)
                  | otherwise = inb (vsub xs ys) ys (z+1)
      
                  
      -- xs = ys + 1
      cstep xs ys | negative rsO = (q-1, vsub xs (bmul ys (q-1)))
                  | vless rsO ys = (q, rsO)
                  | vless rs1 ys = (q + 1,rs1) 
                  | otherwise = (q + 2, rs2)
                  where rsO = vsub xs (bmul ys q) 
                        rs1 = vsub rsO ys 
                        rs2 = vsub rs1 ys
                        q   = (guess xs ys) - 2 
                              --guess=> ys에 xs가 몇 번이나 들어가는 지(+-1의 오차)
                                          -- guess [1,3,2] [1,4] -> b=9
                                          -- guess [1,3,2] [2,3] -> (1*10+3) `div` 2 -> 6
                                          -- guess [1,9,1] [2,9] -> 19 div 2 -> 9   
      -- ex) dstep [2,9] (0, [2,0]) 0
      --     = cstep [2,0,0] [2,9]
      --     =(6,[2,6])
      
      -- cstep으로 가는 dstep 예제
      -- divalg [2,8,9] [2,9]
      -- =>scanl ( dstep [2,9] ) ( 0, [2] ) ( [8,9] )
      -- =>first, (0,[2])                             (1)
      -- =>next, dstep [2,9] (0, [2]) 8
      --       =>astep, (0, [2,8])                    (2)
      --       , dstep [2,9] (0, [2,8]) 9
      --       =>cstep [2,8,9] [2,9]
      --         -> (9, [2,8])                        (3)
      -- [(0,[2]),(0,[2,8]),(9,[2,8])]
      guess (x0 : x1 : xs) (y1 : ys) | x0 >= y1 = b-1
                                     | otherwise =(x0 * b + x1) `div` y1  
                                     where b = 10
      
      
      -- guess [1,3,2] [1,4] -> b=9
      -- guess [1,3,2] [2,3] -> (1*10+3) `div` 2 -> 6
      -- guess [1,9,1] [2,9] -> 19 div 2 -> 9