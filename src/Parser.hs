module Parser (LamExpr (..), parser) where

import Text.Parsec (ParseError, Parsec, between, char, many1, noneOf, parse, sepBy1, (<|>))

-- A 󰘧 expression is:
-- a name (any sequence of non-blank characters)
-- a function abstraction: 󰘧<name>.<body> 
--    where body is any 󰘧 expression
-- an application: (<function expression> <argument expression>)
--    where function expression is any lambda expression
--          argument expression is any lambda expression
data LamExpr
    = Name String
    | Function String LamExpr
    | Application LamExpr LamExpr
    deriving (Eq)

instance Show LamExpr where
    show (Name s) = s
    show (Function n l) = "\984615" ++ n ++ "." ++ show l
    show (Application l1 l2) = "(" ++ show l1 ++ " " ++ show l2 ++ ")"

-- name: parses a name expression
name :: Parsec String st LamExpr
name = Name <$> many1 (noneOf [' ', '.', '(', ')'])

-- function: parses a function abstraction
function :: Parsec String st LamExpr
function = do
    _ <- char '\\'
    (Name n) <- name
    _ <- char '.'
    Function n <$> expression

-- application: parses a function application
application :: Parsec String st LamExpr
application = between (char '(') (char ')') $ do
    exprs <- expression `sepBy1` char ' '
    case exprs of
        [exp1, exp2] -> pure (Application exp1 exp2)
        _ -> undefined

-- expression: parses any 󰘧 expression 
expression :: Parsec String st LamExpr
expression = application <|> function <|> name

-- parser: takes a string and parses it.
parser :: String -> Either ParseError LamExpr
parser = parse expression "lc"
