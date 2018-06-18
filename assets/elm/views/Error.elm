module Error exposing (..)

import Html exposing (..)
import Ms exposing (..)
import Model exposing (Model)

notFoundPage : Model -> Html Ms.Msg
notFoundPage model =
    h1 [] [ text "Page not found" ]