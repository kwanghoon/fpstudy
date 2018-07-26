module Ch4_3 where 
import Data.List
import Data.String

type TEXT = String -- "I have a bag. \n I eat ice cream."
type LINE = String -- "I have a bag"
type WORD = String -- "I"
type PARA = [LINE] 

-- TEXT <-> LINE <-> WORD
--               <-> PARA

-- 1) \n : lines', unlines'
text = "It's      hot.\n\n It's very hot."
lines' :: TEXT -> [LINE]
lines' xs = lines xs
-- lines' text1   --> ["It's      hot.",""," It's very hot."]
unlines' :: [LINE] -> TEXT
unlines' xss = init (unlines xss)
-- unlines' (lines text1) --> It's      hot.\n\n It's very hot."

-- 2) ' ' : words', unwords'
line = "It's hot."
words' :: LINE -> [WORD]
words' xs = words xs
-- map words' (lines' text) --> [["It's","hot."],[],["It's","very","hot."]]
unwords' :: [WORD] -> LINE
unwords' xss = unwords xss
-- map unwords'(map words' (lines' text)) --> ["It's hot.","","It's very hot."]

-- 3) [] : paras', unparas'
samplelines = [ "It's hot.",
                "It's very hot.",
                "It will be hot.",
                "", --( [] == "" )
                "",
                "",
                "I'm tired.",
                "I have some coffee."]

a = ["A","B","","Z"]
breakon xs xss  | xs==[] = [[]] ++ xss
                | otherwise = [[xs] ++ head xss] ++ tail xss
--              "Z" $ [[]] --> [["Z"] ++ []] ++ [] = [["Z"]]
--              "" $ [["Z"]] --> [[]] ++ [["Z"]] = [[],["Z"]]
--              "B" $ [[],["Z"]] --> [["B"] ++ []] ++ [["Z"]] = [["B"],["Z"]]
--              "A" $ [["B"],["Z"]] --> [["A","B"]] ++ [["Z"]] = [["A","B"],["Z"]]
paras' :: [LINE] -> [PARA]
paras' yss = filter (/=[]) ( foldr (breakon) [[]] yss)
--                      "A" $ ("B" $ ("" $ ( "Z" $ [[]] )))
--                      "A" $ ("B" $ ("" $ [["Z"]]))
--                      "A" $ ("B" $ ([[],["Z"]]))
--                      "A" $ [["B"],["Z"]]
--                      [["A","B"],["Z"]]

unparas' :: [PARA] -> [LINE]
unparas' xsss = intercalate [[]] xsss
--              [["A","B"],["Z"]]
--              [["A","B"]] ++ [[]] ++ [["Z"]]
--              --> ["A","B","","Z"]

-- 4) count
countlines = length . lines'
countwords = length . concat . map words' . lines'
countwords' = length . words'
countparas = length . paras' . lines'

-- 5) nomalize
b = "I have  piano."
parse = map (map words') . paras' . lines'
--      map (map words') . paras' ["I have  piano."]
--      = map (map words') [["I have  piano."]]
--      = [map words' ["I have  piano."]]
--      = [[words' "I have  piano."]]
--      = [[["I","have","piano."]]]      
unparse = unlines' . unparas' . map (map unwords')
--        = unlines' . unparas' . [map unwords' [["I","have","piano."]]]
--        = unlines' . unparas' . [[unwords' ["I","have","piano."]]]
--        = unlines' . unparas' . [["I have piano."]]
--        = unlines' ["I have piano."]
--        == "I have piano."

c = "I have      apple. \n\n\n\n I     have   pineapple. \n I    have orange."
nomalize = unparse . parse


-- 5) filltext
d = ["A","AB","ABC"]
-- fill 4 d
--greedy :: Int -> [WORD] -> Int
greedy m ws = maximum [length us | us <- inits ws, (length . unwords') us <= m]
--                     inits ws = [[],["A"],["A","AB"],["A","AB","ABC"]]
--                               "", "A", "A AB", "A AB ABC"

fill :: Int -> [WORD] -> [[WORD]]
fill m ws | ws==[] = []
          | otherwise = [fstline] ++ fill m restwds
                where fstline = take n ws
                      restwds = drop n ws
                      n = greedy m ws
--                      ["A","AB"] + fill m ["ABC"]

e = "I like lone. I like bare. I like tiger."
linewords = concat . map words'
textparas = map linewords. paras'.lines'
filltext m = unparse . map (fill m) . textparas