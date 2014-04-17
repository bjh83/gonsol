module GameEngine where

import Control.Monad.State
import GameElements
import Utils


-- Takes a mapping from playerNames to players a player's name and a GameState
-- and creates a pair representing the next player and the next state.
takeTurn :: [(String, Player)] -> String -> GameState -> (String, IO GameState)
takeTurn players playerName state =
  let currentPlayer = snd . head . filter (\(name, action) -> name == playerName) players
  in (next playerName $ fst . unzip players, currentPlayer action)

-- Takes a function that transforms the current state into the next state and 
-- applies the function until the game concludes.
gameLoop :: (String -> GameState -> (String, IO GameState)) -> String -> GameState -> IO GameState
gameLoop takeTurn' player state =
  let (nextPlayer, wrappedState) = takeTurn' player state
  in do nextState <- wrappedState
        if gameOver nextState
        then return nextState
        else gameLoop takeTurn' nextPlayer nextState

-- Takes a mapping from names to players and and a starting state and transforms
-- the game state until the game is over.
runGame :: [(String, Player)] -> GameState -> IO GameState
runGame players state =
  let firstPlayer = fst . head players
      takeTurn' = takeTurn players
  in gameLoop takeTurn' firstPlayer state
