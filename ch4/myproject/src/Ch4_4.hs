module Ch4_4 where

import Data.List


--펜을 든 거북이의 그림 그리기 게임--
-- state == (direction, pen, point)
-- direction == num            -- 0 (North), 1 (East), 2 (South), 3 (West)
-- pen == bool                 -- False(pen-up), True(pen-down)
-- point == (num, num)         -- (x,y)


move (a, p, (x, y)) | a == 0 = (0, p, (x - 1, y))
                    | a == 1 = (1, p, (x, y + 1))
                    | a == 2 = (2, p, (x + 1, y))
                    | a == 3 = (3, p, (x, y - 1)) 



right (d, p, (x, y)) = ((d + 1) `mod` 4, p, (x, y))
---------------------exercise--------------------------
left  (d, p, (x, y)) = ((d + 3) `mod` 4, p, (x, y)) 
up    (d, p, (x, y)) = (d, False, (x, y)) 
down  (d, p, (x, y)) = (d, True, (x, y)) 
---------------------------------------------------------



turtle xs = scanl applyto (0, False, (0, 0)) xs
applyto x f = f x
-- *Main Ch4_4 Lib> turtle [move, move, move]
-- scanl applyto initstate [move, move, move]
-- = [ initstate
--   , initstate `applyto` move
--   , (initstate `applyto` move) `applyto` move
--   , ((initstate `applyto` move) `applyto` move) `applyto` move
--   ]
-- [(0,False,(0,0)),(0,False,(-1,0)),(0,False,(-2,0)),(0,False,(-3,0))]
-- *Main Ch4_4 Lib> turtle [down, move, move, right, move, up, move, move, right, down, move, move]
-- [(0,False,(0,0)),(0,True,(0,0)),(0,True,(-1,0)),(0,True,(-2,0)),(1,True,(-2,0)),(1,True,(-2,1)),(1,False,(-2,1)),(1,False,(-2,2)),(1,False,(-2,3)),(2,False,(-2,3)),(2,True,(-2,3)),(2,True,(-1,3)),(2,True,(0,3))]




display = pintt . symbolise . bitmap . trail . turtle

-------------------------exercise 4.4.3--------------------------
trail ps = foldl trail_TF [] ps
trail_TF xy (a, p, (x, y)) | p == True = xy ++ [(x,y)]
                           | p == False = xy
-- *Main Ch4_4 Lib> trail [(0,False,(0,0)),(0,True,(0,0)),(0,True,(-1,0)),(0,True,(-2,0)),(1,True,(-2,0)),(1,True,(-2,1)),(1,False,(-2,1)),(1,False,(-2,2)),(1,False]
-- [(0,0),(-1,0),(-2,0),(-2,0),(-2,1),(-2,3),(-1,3),(0,3)]
-----------------------------------------------------------------
-- graph ps = fir_lst ps (bitmap ps)

bitmap ps = [[(x, y) `elem` ps | y <- yran] | x <- xran]
            where xran = range (map fst ps)
                  yran = range (map snd ps)
range zs = [minimum zs .. maximum zs]
-- *Main Ch4_4 Lib> bitmap [(0,0),(-1,0),(-2,0),(-2,0),(-2,1),(-2,3),(-1,3),(0,3)]
-- [[(-2,0),(-2,1),(-2,2),(-2,3)],[(-1,0),(-1,1),(-1,2),(-1,3)],[(0,0),(0,1),(0,2),(0,3)]]

fir_lst ps [] = []
fir_lst ps ts = [sec_lst ps (head ts)] ++ fir_lst ps (tail ts)
sec_lst ps [] = []
sec_lst ps tss | elem (head tss) ps = [True] ++ sec_lst ps (tail tss)
               | otherwise = [False] ++ sec_lst ps (tail tss)
-- *Main Ch4_4 Lib> graph [(0,0),(-1,0),(-2,0),(-2,0),(-2,1),(-2,3),(-1,3),(0,3)]
-- [[True,True,False,True],[True,False,False,True],[True,False,False,True]]


-------------------------exercise 4.4.5--------------------------
symbolise ps = fir_sym ps
fir_sym [] = []
fir_sym ps = [sec_sym (head ps)] ++ fir_sym (tail ps)
sec_sym [] = []
sec_sym ps  | head ps = ['o'] ++ sec_sym (tail ps)
            | otherwise = ['.'] ++ sec_sym (tail ps)
-- *Main Ch4_4 Lib> symbolise [[True,True,False,True],[True,False,False,True],[True,False,False,True]]
-- ["oo.o","o..o","o..o"]
-----------------------------------------------------------------

-------------------------exercise 4.4.3--------------------------
pintt ps = putStrLn (layout ps)

layout pss = map addnewline pss
             where addnewline ps = ps ++ ['\n']

-- layout ps = foldl flatten [] ps
-- flatten xy ps = xy ++ ps ++ ['\n']              -- ++ 줄바꿈
-- *Main Ch4_4 Lib> display [down, move, move, right, move, up, move, move, right, down, move, move]
-- oo.o
-- o..o
-- o..o
-----------------------------------------------------------------

fastbitmap ps = [[ps2  /= [] | ps2 <- splitwith snd yran ps1]
                              | ps1 <- splitwith fst xran ps]
                  where xran = range (map fst ps)
                        yran = range (map snd ps) 
splitwith f xs ys = [[y | y <- ys, f y == x] | x <- xs] 


display2 = pintt . symbolise . fastbitmap . trail . turtle
-- *Main Ch4_4 Lib> display2 [down, move, move, right, move, up, move, move, right, down, move, move]
-- oo.o
-- o..o
-- o..o