module HW09A00819792 where

--Diana Barrios
--A00819792

transpose :: [[Int]] -> [[Int]]
transpose [] = []
transpose (x:xs) = (map x mat) : transpose(map xs mat)

multiplicationM :: [[Int]] -> [[Int]] -> [[Int]]
multiplicationM [] = []


multiplicationR:: [Int] -> [[Int]] -> [[Int]]
multiplicationR row (y:ys) = sum  (map (\(row,y) -> row*y) (zip row y)) :: multiplicationR row ys