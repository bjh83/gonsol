module Utils where


-- Drops elements from the list until either the predicate ceases to hold
-- or the list becomes empty. Drops inclusively.
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile _ [] = []
dropWhile predicate (x : xs) =
  if not predicate x
  then xs
  else dropWhile predicate xs

doWhile :: (a -> Bool) -> (a -> a) -> a
doWhile pred mutator value =
  let newValue = mutator value
  in if pred newValue then newValue
                      else doWhile pred mutator newValue

doNTimes :: (a -> a) -> Int -> a -> a
doNTimes _ 0 a = a
doNTimes mutator n a = doNTimes (n - 1) $ mutator a

fill :: a -> Int -> [a]
fill value n = doNTimes m (value :) []

-- If you consider a list to be connected at the head and tail then this finds
-- the element that immediate follows given element.
next :: (Eq a) => a -> [a] -> a
next elem list =
  | null remainder = head list
  | otherwise = head remainder
    where remainder = dropWhile (\x -> x \= elem) list

