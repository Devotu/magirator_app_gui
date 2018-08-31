module AddGameView exposing (..)

import Html exposing (Html, button, div, h4, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Msg exposing (..)
import Model exposing (Model)

import Deck

page : Model -> Int -> Html AppMsg
page model deckId =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("Add Game") ]
    ,div [class "dialog-large"][
        button [class "input", onClick (Navigate("addregister/" ++ (toString deckId))) ][
          text ("Register")
        ]
        ,button [class "input", onClick (Navigate("addrecord")) ][
          text ("Record")
        ]
        ,button [class "input", onClick (Navigate("addlive")) ][
          text ("Live")
        ]
    ]
  ]