module Player.Board where

import Utils
import GameElements


data Board = Board { board :: [[Char]]
                   , width :: Int
                   , height :: Int
                   }

set :: [[a]] -> (Int, Int) -> a -> [[a]]
set outerList (x, y) value =
  let outerZipper = doNTimes y left $ fromList outerList
      innerZipper = doNTimes x left $ fromList outerZipper
      newOuterZipper = replace (toList . replace value innerZipper) outerZipper
  in toList newOuterZipper

setInBoard :: Board -> (Int, Int) -> Char -> Board
setInBoard gameBoard index char = 
  let newBoard = set (board gameBoard) index char
  in Board newBoard (width gameBoard) (height gameBoard)

initBoard :: Char -> (Int, Int) -> Board
initBoard char (width, height) =
  let row = fill char width
      list = fill row height
  in Board list width height

render :: String -> GameState -> Board
render name state = 
  let board = initBoard ' ' (30, 20)
      setInBoard' = \board, unit -> setInBoard board (position unit) 'D'
  in foldl setInBoard board $ getAllUnits state
