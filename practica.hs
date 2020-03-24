module Practica where

import Data.List
import Data.Function

maxN :: Int -> Int -> Int
maxN x y = if x >= y
    then x
    else y

getMax :: [Int] -> Int
getMax [] = minBound :: Int
getMax (x:xs) = maxN x (getMax xs)

minN :: Int -> Int -> Int
minN x y = if x >= y
    then y
    else x

getMin :: [Int] -> Int
getMin [] = maxBound :: Int
getMin (x:xs) = minN x (getMin xs)


recursion :: [Int] -> (Int,Int)
recursion lst = (getMin lst, getMax lst)

data Record = Record (String, Int) deriving Show
--(Record ("F",16))
--(Record ("M",14))
--(Record ("M",15))
--(Record ("F",13))

data Table = Table [Record] deriving Show
--(Table [(Record ("F",16)), (Record ("M",14)), (Record ("M",15)), (Record ("F",13))])

convertT :: Table -> [Record]
convertT (Table []) = []
convertT (Table (x:xs)) =  (x:(convertT (Table xs)))

insertR :: Record -> Table -> Table
insertR (Record r) (Table []) = (Table [(Record r)])
insertR (Record (g, h)) (Table (Record (gender,height):xs))
    | h < height = (Table ((Record (g,h)):(Record (gender,height)): xs  ) )
    | otherwise =  (Table ((Record (gender,height)): convertT (insertR (Record (g,h)) (Table xs)) ) )
        
sortT :: Table -> Table
sortT (Table []) = (Table [])
sortT (Table (x:xs)) = insertR x (sortT (Table xs))

buildSon :: [Char] -> [Char] -> Int -> [Char]
buildSon x y 0 = y
buildSon (x:xs) (y:ys) k = x:(buildSon xs ys (k-1)) 

crossOver :: [Char] -> [Char] -> Int -> ([Char] ,[Char])
crossOver mom dad n = ((buildSon mom dad n),(buildSon dad mom n))

data Color = Red | Black deriving Show
data Suit = Diamonds | Clubs | Hearts | Spades deriving Show
data Rank = Jack | Queen | King | Ace deriving Show
data Card = Card (Rank, Suit) deriving Show
--(Card (Queen, Hearts))

getValue :: Card -> Int
getValue (Card (Jack,_)) = 11
getValue (Card (Queen,_)) = 12
getValue (Card (King,_)) = 13
getValue (Card (Ace,_)) = 1


getColor :: Card -> String
getColor (Card (_,Diamonds)) = "Red"
getColor (Card (_,Clubs)) = "Black"
getColor (Card (_,Hearts)) = "Red"
getColor (Card (_,Spades)) = "Black"

removeLastN :: Int -> [Int] -> [Int]
removeLastN k [] = []
removeLastN k (x:xs) = if (length(xs)+1) == k
    then []
    else x : removeLastN k xs

data Complex = Complex (Float,Float) deriving Show

addC :: Complex -> Complex -> Complex
addC (Complex (r,i)) (Complex (real,imaginary)) = (Complex (r+real,i+imaginary)) 

multiplicationC :: Float -> Complex -> Complex
multiplicationC c (Complex (r,i)) = (Complex (r*c,i))

getRealC :: Complex -> Float
getRealC (Complex (r,_)) = r

getImaginaryC :: Complex -> Float
getImaginaryC (Complex (_,i)) = i

data RGB = RGB (Float,Float,Float) deriving Show

enigmaB :: [Int] -> Int
enigmaB [] = 0
enigmaB (x:y) = x*2

enigmaA  :: [Int] -> [Int]
enigmaA x = (\x y -> map y x) x (\x -> x + 1)

enigmaX  :: [Double] -> Double  -> [(Bool , Bool)]
enigmaX x y = zip (map (> y) x) (map (< y) x)

enigmaD  :: Char  -> [(Char , Char)] -> [Char]
enigmaD x [] = [x]
enigmaD x ((a, b):c) = a:b:( enigmaD b c)