module Parser.Parser where

import GameElements


data PlayerStateIDMapping = PlayerStateIDMapping { name :: String
                                                 , units :: [(Int, Unit)]
                                                 } deriving (Eq)

type GameStateIDMapping = [PlayerStateIDMapping]

parse :: GameStateIDMapping -> String -> String -> Maybe GameStateIDMapping
parse gameState _ _ = Just gameState
