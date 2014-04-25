module Main where

import GameElements
import GameEngine
import Player.HumanPlayer


main = do
  runGame [("Human", takeTurn "Human")] [PlayerState "Human" [soldier]]
  putStrLn "Done."
