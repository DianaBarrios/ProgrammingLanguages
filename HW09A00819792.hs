module HW09A00819792 where

import Data.List
import Data.Function

--Diana Barrios
--A00819792

transposeM :: [[Int]] -> [[Int]]
transposeM ([]:xs) = []
transposeM mat = (map head mat) : transposeM(map tail mat)

multiplicationR :: [Int] -> [[Int]] -> [Int]
multiplicationR row [] = []
multiplicationR row (y:ys) = sum  (map (\(row,y) -> row*y) (zip row y)) : multiplicationR row ys

multiplicationM :: [[Int]] -> [[Int]] -> [[Int]]
multiplicationM ([]) x = []
multiplicationM (x:xs) matB = (multiplicationR x (transpose matB)) : (multiplicationM xs matB)

--[("Male", 178), ("Female", 165), ("Female", 165)]
getAvg :: [([Char], Integer)] -> [([Char], Integer)]
getAvg fTable = [(fst (head fTable), ((sum (map snd fTable)) `div` fromIntegral(length fTable)))]

summarization :: [([Char], Integer)] -> [([Char], Integer)]
summarization [] = []
summarization table = getAvg (filter (\(gender,g) ->gender == "Male") table) ++ getAvg (filter (\(gender,g) ->gender == "Female") table)

listComprehension :: [([Char], Integer)] -> Integer -> [([Char], Integer)]
listComprehension [] _ = []
listComprehension ((gender,height) : rest) x = if height < x
    then (gender, height) : listComprehension rest x
    else listComprehension rest x

data Node = Node (Integer, [Integer]) deriving Show
--(Node (1,[2,3]))
--(Node (2,[1,3,4,5]))
--(Node (3,[1])) 

data Graph = Graph [Node] deriving Show
--(Graph [(Node (1,[2,3])), (Node (2,[1,3,4,5])), (Node (3,[1]))])

maxNode :: Node -> Node -> Node
maxNode (Node (n1,edges1)) (Node (n2,edges2))
    | length edges1 >= length edges2 = (Node (n1,edges1))
    | otherwise = (Node (n2,edges2))

operationsInGraph :: Graph -> Node
operationsInGraph (Graph [Node (x)]) = (Node ((fst x), (snd x)))
operationsInGraph (Graph (x:xs)) = maxNode x (operationsInGraph (Graph xs))

exists:: Integer -> Node -> Bool
exists n (Node (i,[])) = False
exists n (Node (i,(x:xs))) = if x == n
    then True
    else exists n (Node (i,xs))

findPath :: Node -> Node -> Bool
findPath (Node (n1,edges1)) (Node (n2,edges2)) 
    | exists n1 (Node (n2,edges2)) == True = True
    | exists n2 (Node (n1,edges1)) == True = True
    | otherwise = False

{-enigmaE :: [Int] -> Int -> [[Int]]
enigmaE [] z = [z : []]
enigmaE (x:y) z = [x*2] : enigmaE y (z+1)

enigmaF :: [t] -> Int -> [(t, Int)]
enigmaF [] x = []
enigmaF (x:xs) y = if even (length (xs))
    then (x, length (xs)*y) : enigmaF (xs) y
    else enigmaF xs y

enigmaG :: [Int] -> [Int] -> Int
enigmaG v w = sum (filter (>0) (map (\(x,y) -> x +y) (zip v w)))
-}
