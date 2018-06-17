module Error exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)

notFoundPage : Html Msg
notFoundPage =
    h1 [] [ text "Page not found" ]