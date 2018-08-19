module DeckList exposing (..)

import Html exposing (Html, button, div, h4, li, ol, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (AppMsg)


page : Model -> Html AppMsg
page model =
    div [class "mr-main flex-column flex-start"][
        h4 [][ text ("Decks") ]
        ,div [class "dialog-large"][
            div [class "list"][
                ol [][text "test1"]
                ,ol [][text "test2"]
            ]
            ,div [class "split-choice"][
                button [class "input half-width", onClick ( Msg.Navigate("home") ) ][ 
                    text ("Back") 
                ]
                ,button [class "input", onClick (Msg.Navigate("newdeck")) ][
                    text ("New Deck")
                ]
            ]
        ]
    ]