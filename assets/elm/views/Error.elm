module Error exposing (..)

import Html exposing (..)
import Ms exposing (..)

notFoundPage : Html Ms.Msg
notFoundPage =
    h1 [] [ text "Page not found" ]