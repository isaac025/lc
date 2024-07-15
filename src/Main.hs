module Main where

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
    if l == "(quit)" then pure () else putStrLn l >> repl
