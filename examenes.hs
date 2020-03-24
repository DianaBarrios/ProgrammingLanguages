module practica where

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

data Record = Record (String, Int)
data Table = Table [Record]

insert :: Record -> Table -> Table
insert (Record r) (Table []) = (Table [(Record r)])
insert (Record (g, h)) (Table (Record (gender,height):xs))
    | h <= height = (Table ((Record (g,h)): xs  ) )
    | otherwise = insert (Record (g,height)) (Table xs)

sort :: Table -> Table
sort (Table []) = (Table [])
sort (Table (x:xs)) = insert x (sort (Table xs))