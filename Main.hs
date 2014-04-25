module Main where

import GameElements
import GameEngine
import Player.HumanPlayer


main = do
  putStrLn "Things are happending!!!"
  runGame [("Human", takeTurn "Human")] [PlayerState "Human" [soldier]]
  putStrLn "Done."
