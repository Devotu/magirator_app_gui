module Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Msg exposing (..)
import Model exposing (Model)

homePage : Model -> Html AppMsg
homePage model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("Home") ]
    ,div [class "dialog-large"][
        button [class "input", onClick (Navigate("newdeck")) ][
        text ("New Deck")
      ]
    ]
  ]