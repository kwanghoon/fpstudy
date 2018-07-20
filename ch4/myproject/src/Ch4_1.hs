module Ch4_1 where

units = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
teens = ["ten", "eleven", "twelve", "thirteen", "fourteen", "fifteen", "sixteen", "seventeen", "eighteen", "nineteen"]
tens = ["twenty", "thirty", "forty", "fifty", "sixty", "seventy", "eighty", "ninety"]

combine2 (t, u) | t == 0 && u-1 >= 0 = units !! (u - 1)
                | t == 1 = teens !! u
                | u == 0 && t-2 >= 0 = tens !! (t - 2)
                | otherwise = tens !! (t - 2) ++ "-" ++ units !! (u - 1)


digits2 n = (n `div` 10, n `mod` 10)
convert2 n = combine2 (digits2 n)

combine3 (h, t) | h == 0 && t-1 >= 0 = convert2 t
                | t == 0 && h-1 >= 0 = units !! (h - 1) ++ " hundred"
                | otherwise = units !! (h - 1) ++ " hundred and " ++ convert2 t

digits3 n = (n `div` 100, n `mod` 100)
convert3 n = combine3 (digits3 n)

link h | h < 100 = " and "
       | otherwise = " "

combine6 (m, h) | m == 0 && h-1 >= 0 = convert3 h
                | h == 0 && m-1 >= 0 = convert3 m ++ " thousand"
                | otherwise = convert3 m ++ " thousand" ++ link h ++ convert3 h

digits6 n = (n `div` 1000, n `mod` 1000)
convert6 n = combine6 (digits6 n)

convert n = convert6 n

-- *Ch4_1> convert 308000
-- "three hundred and eight thousand"
-- *Ch4_1> convert 369027
-- "three hundred and sixty-nine thousand and twenty-seven"
-- *Ch4_1> convert 369401
-- "three hundred and sixty-nine thousand four hundred and one"

