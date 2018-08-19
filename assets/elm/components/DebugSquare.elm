module DebugSquare exposing (..)

import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Model exposing (Model)

debugSquare : Model -> Html never
debugSquare model =
    div [class "dialog-large debug-box"][
                div [][
                    p [][ text ("Status: " ++ model.status) ]
                    ,p [][ text ("Decklist: " ++ toString model.deckList) ]
                ]
            ]