module NewDeck exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Ms exposing (..)
import Model exposing (Model)
import Json.Encode exposing (..)
import Request exposing (..)

newDeckPage : Model -> Html Ms.Msg
newDeckPage model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("New Deck") ]
    ,div [class "dialog-large"][
        button [class "input", onClick ( 
          Post (newDeck model)
        ) ][
        text ("New")
      ]
    ]
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

newDeck : Model -> Request
newDeck model =
  let 
    deck = model.newDeck
  in
  {
    endpoint = "newdeck"
    , object = Json.Encode.object [
      ("name", string deck.name)
      , ("theme", string deck.theme)
    ]
  }