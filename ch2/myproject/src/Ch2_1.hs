module Ch2_1 where 

-- 2.1 Numbers
square n = n * n

opEx1 = 3 - 7 - 2
opEx2 = 3 * 7 + 4.1
opEx3 = 3 * (7 + 4.1)
opEx4 = square 3 * 4
opEx5 = 3 ^ 4 * 2

-- 2.1.1 Precedence
-- ^ --> * , / --> +, -
preEx1 = 3 ^ 4 * 5      -- (3 ^ 4) * 5
preEx2 = 3 * 7 + 4.1    -- (3 * 7) + 4.1
preEx3 = square 3 * 4   -- (square 3) * 4
preEx4 = -3 ^ 4         -- -(3 ^ 4)

-- 2.1.2 Order of association
xor :: Bool -> Bool -> Bool
xor a b = a /= b

assEx1 = 5 - 4 - 2      -- (5 - 4) - 2
assEx2 = 3 ^ 4 ^ 5      -- (3 ^ 4) ^ 5
assEx3 = xor True (xor True False)
assEx4 = xor (xor True True) False

-- 2.1.3 div and mod
dEx1 = 7 `div` 3            -- div 7 3
dEx2 = (-7) `div` 3         -- div (-7) 3
mEx1 = 7 `mod` 3            -- mod 7 3
mEx2 = (-7) `mod` 3         -- mod (-7) 3

-- 2.1.4 Operators and sections
both f x = f x x
_ = let f = (+1)
    in f 3
_ = let g = (1+)
    in g 4

-- 2.1.5 Example: computing square roots
eps = 0.0001
improve x y = (y + x / y) / 2
satis x y = abs(y ^ 2 - x) < eps
newton x = until (satis x) (improve x) x

newton1 = newton 3
sqrt1 = sqrt 3

-- Exercise
ex1_1 = 3 `div` 1 * 3
ex1_2 = 3 * 7 `div` 4
ex1_3 = 6 `div` 2 * 8 `div` 4

-- (x + y) `mod` z
-- = (x `mod` z + y `mod` z) `mod` z

-- x * (y mod z)
-- = (x * y) mod (x * z)