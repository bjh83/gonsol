module Main where

import Player.HumanPlayer


main = do
  putStrLn $ runGame [("Human", takeTurn)] [PlayerState "Human" [soldier]]
