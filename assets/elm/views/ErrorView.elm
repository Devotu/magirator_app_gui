module ErrorView exposing (..)

import Html exposing (..)
import Msg exposing (..)
import Model exposing (Model)

notFoundPage : Model -> Html AppMsg
notFoundPage model =
    h1 [] [ text "Page not found" ]