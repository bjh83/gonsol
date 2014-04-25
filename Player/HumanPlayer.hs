module Player.HumanPlayer where

import Control.Monad.Trans
import Control.Monad.Trans.Maybe
import Data.Maybe
import GameElements
import Parser.Parser
import Player.Board
import Player.PlayerInteraction


takeTurn :: String -> GameState -> IO GameState
takeTurn name state = 
  let board = render name state
      unitIDMap = zip [0..] $ getAllUnits state
      gameStateIDMapping = createIDMapping unitIDMap state
  in fmap fromIDMapping $ getStateFromUser name board gameStateIDMapping

getStateFromUser :: String -> Board -> GameStateIDMapping -> IO GameStateIDMapping
getStateFromUser name gameBoard gameStateIDMapping = 
  let newState = runMaybeT $ do
      lift $ showBoard gameBoard
      input <- lift getLine
      MaybeT . return $ parse gameStateIDMapping name input
  in do
    unwrappedState <- newState
    if isJust unwrappedState then return $ fromJust unwrappedState
                             else getStateFromUser name gameBoard gameStateIDMapping

lookup :: (Eq k) => [(k, v)] -> k -> v
lookup index key = snd . head . filter (\(k, _) -> k == key) $ index

reversePairs :: [(k, v)] -> [(v, k)]
reversePairs = map (\(k, v) -> (v, k))

createIDMapping :: [(Int, Unit)] -> GameState -> GameStateIDMapping
createIDMapping unitIDMap =
  let unitToID = reversePairs unitIDMap
      lookup' = Player.HumanPlayer.lookup unitToID
  in map (\(PlayerState name units) -> PlayerStateIDMapping name $ map (\unit -> (lookup' unit, unit)) units)

fromIDMapping :: GameStateIDMapping -> GameState
fromIDMapping = map (\(PlayerStateIDMapping name units) -> PlayerState name $ (snd . unzip) units)
