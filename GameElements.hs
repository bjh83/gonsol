module GameElements where

data Unit = Unit { position :: (Int, Int)
                 , health :: Int
                 , attack :: Int
                 , defense :: Int
                 } deriving (Eq, Show)

soldier = Unit (0, 0) 100 20 20

data PlayerState = PlayerState { name :: String
                               , units :: [Unit]
                               } deriving (Eq, Show)

type GameState = [PlayerState]

type Player = GameState -> IO GameState

getAllUnits :: GameState -> [Unit]
getAllUnits state = state >>= units

getAllNames :: GameState -> [String]
getAllNames = map name

getPlayerByName :: String -> GameState -> PlayerState
getPlayerByName playerName gameState = head $ filter ((playerName ==) . GameElements.name) gameState
