module Main where

import Control.Monad (when)
import Parser
import System.Exit (exitSuccess)
import System.IO (BufferMode (LineBuffering, NoBuffering), hSetBuffering, stdout)

main :: IO ()
main = do
    putStrLn "Welcome to Lambda Calculus Interpreter!"
    hSetBuffering stdout NoBuffering -- in order to write our expressions on same line as repl
    repl

repl :: IO ()
repl = do
    putStr "\984615> "
    l <- getLine
    when (l == "(quit)") exit
    let parsed = parser l
    case parsed of
        Left _ -> putStrLn "Error"
        Right le -> print le
    repl

exit :: IO ()
exit = do
    hSetBuffering stdout LineBuffering -- default line buffering
    exitSuccess
