module Main where

import Control.Monad (when)

import Parser
import System.IO (BufferMode (LineBuffering, NoBuffering), hSetBuffering, stdout)

main :: IO ()
main = do
    putStrLn "Welcome to Lambda Calculus Interpreter!"
    hSetBuffering stdout NoBuffering -- in order to write our expressions on same line as repl
    repl
    hSetBuffering stdout LineBuffering -- default line buffering

repl :: IO ()
repl = do
    putStr "\984615> "
    l <- getLine
    when (l == "(quit)") $ do
        pure ()

beta :: LamExpr -> LamExpr
beta (Application l1 _l2) =
    case l1 of
        (Function _n _b) -> undefined
        _ -> undefined
beta l = l
