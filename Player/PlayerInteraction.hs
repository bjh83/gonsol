{-# INCLUDE C/draw_board.h #-}
{-# LANGUAGE ForeignFunctionInterface #-}
module Player.PlayerInteraction where

import Foreign
import Foreign.C.Types
import Foreign.C.String

foreign import ccall "draw_board"
    c_showBoard :: Ptr CChar -> CInt -> CInt -> IO ()

showBoard :: Board -> IO ()
showBoard gameBoard = 
  let rawBoard = newArray $ board gameBoard
      rawWidth = fromIntegral . width gameBoard
      rawHeight = fromIntegral . height gameBoard
  in do
    unWrappedBoard <- rawBoard
    showBoard unWrappedBoard rawWidth rawHeight
