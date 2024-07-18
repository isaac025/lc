module LC where

import Parser (LamExpr (..))

beta :: LamExpr -> LamExpr
beta (Application l1 _l2) =
    case l1 of
        (Function _n _b) -> undefined
        _ -> undefined
beta l = l
