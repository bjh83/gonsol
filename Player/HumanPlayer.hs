module Player.HumanPlayer where

import Control.Monad.Maybe
import GameElements
import Parser.Parser
import Player.Board
import Player.PlayerInteraction


data PlayerStateIDMapping = PlayerStateIDMapping { name :: String
                                                 , units :: [(Int, Unit)]
                                                 } deriving (Eq)

type GameStateIDMapping = [PlayerStateIDMapping]

takeTurn :: String -> GameState -> IO GameState
takeTurn name state = 
  let board = render name state
      unitIDMap = zip [0..] $ getAllUnits state
      gameStateIDMapping = createIDMapping unitIDMap state
  in getStateFromUser board gameStateIDMapping $ >>= (fromIDMapping unitIDMap)

getStateFromUser :: Board -> GameStateIDMapping -> IO GameStateIDMapping
getStateFromUser board gameStateIDMapping = 
  let newState = runMaybe $ do
    showBoard board
    input <- lift getLine
    newState <- parse gameStateIDMapping input
  in if isJust newState then fromJust newState
                        else getStateFromUser

lookup :: (Eq k) => [(k, v)] -> k -> v
lookup key = snd . head . filter (\(k, _) -> k == key)

reversePairs :: [(k, v)] -> [(v, k)]
reversePairs = map (\(k, v) -> (v, k))

createIDMapping :: [(Int, Unit)] -> GameState -> GameStateIDMapping
createIDMapping unitIDMap =
  let unitToID = reversePairs unitIDMap
  in map (\(name, units) -> PlayerStateIDMapping name $ map (\unit -> (lookup unitToID, unit)) units)

fromIDMapping :: GameStateIDMapping -> GameState
fromIDMapping unitIDMap =
  map (\(name, units) -> PlayerState name $ map snd . unzip units)
