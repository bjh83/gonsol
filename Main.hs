module Main where

import HumanPlayer


main = do
  putStrLn $ runGame [("Human", takeTurn)] [PlayerState "Human" [soldier]]
