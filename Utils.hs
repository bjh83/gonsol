module Utils where


-- Drops elements from the list until either the predicate ceases to hold
-- or the list becomes empty. Drops inclusively.
dropWhile :: (a -> Bool) -> [a] -> [a]
dropWhile _ [] = []
dropWhile predicate (x : xs) =
  if not predicate x
  then xs
  else dropWhile predicate xs

-- If you consider a list to be connected at the head and tail then this finds
-- the element that immediate follows given element.
next :: (Eq a) => a -> [a] -> a
next elem list =
  | null remainder = head list
  | otherwise = head remainder
    where remainder = dropWhile (\x -> x \= elem) list

