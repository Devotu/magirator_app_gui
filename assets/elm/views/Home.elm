module Home exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Json.Encode
import Msg exposing (..)
import Model exposing (Model)
import Request

homePage : Model -> Html AppMsg
homePage model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("Home") ]
    ,div [class "dialog-large"][
        button [class "input", onClick (Navigate("newdeck")) ][
          text ("New Deck")
        ]
        ,button [class "input", onClick (Msg.PostAndNavigate (deckListRequest model)) ][
          text ("Decks")
        ]
    ]
  ]

deckListRequest : Model -> Request.NavRequest
deckListRequest model =
  {
    action = "deck:list"
    , object = Json.Encode.object []
    , path = "decklist"
    , reset = ""
  }