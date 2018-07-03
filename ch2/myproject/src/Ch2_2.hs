module Ch2_2 where


-- *Main Lib> 2 < 1 + 3
-- True
-- *Main Lib> 2 == 3
-- False
-- *Main Lib> False == True
-- False
-- *Main Lib> False < True
-- True
-- *Main Lib> False > True
-- False

-- 2.2.1 Equality
within eps x y = abs (x - y) < eps 
-- *Main Lib> within 1 2 3
-- False
-- *Main Lib> within 2 2 3
-- True

-- 2.2.2 The logical operators
-- *Main Lib> 1 < 2 && 2 < 3
-- True
-- *Main Lib> 1 < 2 && 2 < 2
-- False
-- *Main Lib> 1 < 2 || 2 < 2
-- True


-- 2.2.3 Examples
leap y = (y `mod` 4 == 0) && (y `mod` 100 /= 0 || y `mod` 400 == 0)   --윤년계산 함수
-- *Main Lib> leap 2000
-- True
-- *Main Lib> leap 2014
-- False


-- 삼각형의 각 변의 길이를 받아 삼각형인지, 이등변삼각형인지, 부등변삼각형인지 구별하는 함수
analyse1 a b c = 
    if a + b < c 
        then 0 
        else 
            if a + b > c && a < b && b < c 
                then 3 
                else 
                    if a + b > c && a /= c && (a == b || b == c) 
                        then 2 
                        else 1


analyse2 a b c  
    | a + b <= c                                = 0        
    | a + b > c && a == c                       = 1
    | a + b > c && a /= c && (a == b || b == c) = 2
    | a + b > c && a < b && b < c               = 3
    | otherwise                                 = 4
