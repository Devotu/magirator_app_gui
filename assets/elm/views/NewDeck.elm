module NewDeck exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Ms exposing (..)
import Model exposing (Model)
import Json.Encode exposing (..)
import Request exposing (..)
import Deck exposing (..)

newDeckPage : Model -> Html Msg
newDeckPage model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("New Deck") ]
    ,div [class "dialog-large"][
      input [class "input input-text", placeholder "name", type_ "text", onInput DeckName][ ]
      ,input [class "input input-text", placeholder "theme", type_ "text", onInput DeckTheme][ ]
      ,div [class "split-choice"][
        button [class "input half-width", onClick ( Navigate("home") ) ][ text ("Back") ]
        ,button [class "input half-width", onClick ( Post (newDeck model) ) ][ text ("Create") ]
      ]
    ]
  ]

newDeck : Model -> Request
newDeck model =
  let 
    deck = model.deck
  in
  {
    action = "deck:create"
    , object = Json.Encode.object [
      ("name", string deck.name)
      , ("theme", string deck.theme)
    ]
  }      
