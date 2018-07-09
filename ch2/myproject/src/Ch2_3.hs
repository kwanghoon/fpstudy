module Ch2_3 where
    ----ASCII code 사용을 위한 Import
    import Data.Char
    
   ------- code
    code :: Char -> Int
    
    code x = ord x
   ------- decode 
    decode :: Int -> Char
    
    decode x = chr x
    
    ------ 공백을 출력하는 함수
    space :: Int -> String
    
    space 1 = " "
    space x = if x > 0 then " " ++ space (x-1) else space 1
    ----- 왼쪽 정렬, 중앙 정렬, 오른쪽 정렬
    ljustify :: Int -> String -> String
    cjustify :: Int -> String -> String
    rjustify :: Int -> String -> String
    
    ljustify n x = if( n > m ) then x++space(n- m) else "overflow"
            where 
                m = length x   
    rjustify n x = if( n > m ) then space(n- m)++x else "overflow"
            where 
                m = length x 
    cjustify n x = if( n > m ) then space(lm)++x++space(rm) else "overflow"
            where 
                m = length x
                lm = (n-m) `div` 2
                rm = (n-m) - lm 
    ------ 아스키 코드 상에서 다음 문자를 출력
    nexlet :: Char -> Char
    
    nexlet 'z' = 'a'
    nexlet 'Z' = 'A'
    nexlet x = if ((65 <= code x) && (code x  <= 90)) 
                    || ((97 <= code x) && (code x <= 122))
                    then decode(code x + 1)
            else '?'
    
    digitval :: Int -> Char
    
    digitval x = decode (48 + x)

    trips x = [(d!!0,d!!1,d!!2) | i <- [1.. length x], d <- [ take 3 (drop (i-1) x) ], length d >= 3]