{-# LANGUAGE ForeignFunctionInterface #-}
module Player.PlayerInteraction where

import Foreign
import Foreign.C.Types
import Foreign.C.String
import Player.Board

foreign import ccall "draw_board"
    c_showBoard :: Ptr CChar -> CInt -> CInt -> IO ()

showBoard :: Board -> IO ()
showBoard gameBoard = 
  let rawBoard = newArray $ map castCharToCChar $ concat $ board gameBoard
      rawWidth = fromIntegral $ width gameBoard
      rawHeight = fromIntegral $ height gameBoard
  in do
    unWrappedBoard <- rawBoard
    c_showBoard unWrappedBoard rawWidth rawHeight

foreign import ccall "initialize"
  initialize :: IO ()

foreign import ccall "terminate"
  terminate :: IO () 
