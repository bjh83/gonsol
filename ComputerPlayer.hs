module ComputerPlayer where

import GameElements


-- takeTurn, in general, must be able to communicate with the outside world;
-- thus, even though the AI is deterministic it must wrap its result to have the
-- same type as the most general case.
takeTurn :: GameState -> IO GameState
takeTurn = return . takeSafeTurn

takeSafeTurn :: GameState -> GameState
