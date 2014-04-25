module Main where

import GameElements
import GameEngine
import Player.HumanPlayer
import Player.PlayerInteraction


main = do
  putStrLn "Things are happending!!!"
  initialize
  runGame [("Human", takeTurn "Human")] [PlayerState "Human" [soldier]]
  terminate
  putStrLn "Done."
