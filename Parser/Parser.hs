module Parser.Parser where

import Player.HumanPlayer


parse :: GameStateIDMapping -> String -> String -> Maybe GameStateIDMapping
parse gameState _ _ = Just gameState
