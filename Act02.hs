module Act02 where

lastElem :: [t] -> t
lastElem [] = error "Empty list"
lastElem [x] = x
lastElem (x:rest) = lastElem rest

dividing :: [t] -> ([t], [t])
dividing [] = ([],[])
dividing xs = splitAt n xs
    where n = length xs `div` 2