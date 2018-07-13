module NewDeck exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Ms exposing (..)
import Model exposing (Model)

newDeckPage : Model -> Html Ms.Msg
newDeckPage model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("New Deck") ]
    ,div [class "dialog-large"][
        button [class "input", onClick (Navigate("home")) ][
        text ("Home")
      ]
    ]
    ,div [class "dialog-large"][
      div [][
        p [][ text ("Status: " ++ model.status) ]
        , p [][ text ("Socket: " ++ toString model.socketStatus) ]
        , p [][ text ("Channel: " ++ toString model.channelStatus) ]
      ]
    ]
  ]