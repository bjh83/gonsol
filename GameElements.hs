module GameElements where

data Unit = Unit { position :: (Int, Int)
                 , health :: Int
                 , attack :: Int
                 , defense :: Int
                 } deriving (Eq)

let soldier = Unit (0, 0) 100 20 20

data PlayerState = PlayerState { name :: String
                               , units :: [Unit]
                               } deriving (Eq)

type GameState = [PlayerState]

type Player = GameState -> IO GameState

getAllUnits :: GameState -> [Unit]
getAllUnits state = state >>= units

getAllNames :: GameState -> [String]
getAllNames = map name

getPlayerByName :: GameState -> String -> PlayerState
getPlayerByName gameState playerName = 
  let pairList = map (\state -> (name state, state)) GameState 
      singleton = filter (\(name, state) -> playerName == name) pairList
  in (\[element] -> element) singleton
