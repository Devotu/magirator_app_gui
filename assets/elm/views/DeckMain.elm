module DeckMain exposing (..)

import Html exposing (Html, button, div, h4, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (AppMsg)

page : Int -> Model -> Html AppMsg
page id model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("Deck id: " ++ toString id) ]
    ,div [class "dialog-large"][
        button [class "input", onClick (Msg.Navigate("newdeck")) ][
          text ("New Deck")
        ]
    ]
  ]