module Challenge03A00819792 where

--Diana Barrios
--A00819792

data Matrix = Matrix [[Integer]] deriving Show

transposeX :: [[Integer]] -> [[Integer]]
transposeX ([]:_) = []
transposeX m = (map head m) : transposeX (map tail m)

transpose :: Matrix -> Matrix
transpose (Matrix m) = (Matrix (transposeX m))

data Info = Info {
    current :: Integer,
    count :: Integer,
    best :: Integer,
    bestCount :: Integer
}

counting :: Info -> Integer -> Info
counting (Info current count best bestCount) x
    | x == current = (Info current (count + 1) best bestCount)
    | count > bestCount = (Info x 1 current count)
    | otherwise = (Info x 1 best bestCount)

--[1,2,3,1,1,1,5]    
mode:: [Integer] -> Integer
mode [] = error "Empty list"
mode lst = best (foldl counting (Info 0 0 0 0) lst)

data Set = Set [Integer] deriving Show

exists:: Integer -> Set -> Bool
exists x (Set []) = False
exists x (Set (m:ms)) = if x == m
    then True
    else exists x (Set ms)

add:: Integer -> Set -> Set
add x (Set set) = if (exists x (Set set)) == True
    then (Set set)
    else (Set (x:set))

remove:: Integer -> Set -> Set
remove _ (Set []) = (Set [])
remove n (Set (x:xs)) = if n == x
    then (Set xs)
    else (add x (remove n (Set xs)))

union:: Set -> Set -> Set
union _ (Set []) = (Set []) 
union a (Set (y:ys)) = if (exists y a) == True
    then union a (Set ys)
    else (add y a)

intersection:: Set -> Set -> Set
intersection _ (Set []) = (Set []) 
intersection a (Set (y:ys)) = if (exists y a) == True
        then add y (intersection a (Set ys))
        else intersection a (Set ys)

mergeSort :: Ord a => [a] -> [a]
mergeSort [] = []
mergeSort [x] = [x]
mergeSort xs = merge (mergeSort as) (mergeSort bs)
     where (as, bs) = splitInHalf xs

splitInHalf :: [a] -> ([a], [a])
splitInHalf [] = ([], [])
splitInHalf [x] = ([x], [])
splitInHalf (x:y:xys) = (x:xs, y:ys)
    where (xs, ys) = splitInHalf xys

merge :: Ord a => [a] -> [a] -> [a]
merge xs [] = xs
merge [] ys = ys
merge (x:xs) (y:ys) = if x < y
    then x:(merge xs (y:ys))
    else y:(merge ys (x:xs))