module NewDeck exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Msg exposing (..)
import Model exposing (Model)
import Json.Encode exposing (..)
import Request exposing (..)
import Deck exposing (formats)
import Input exposing (inputText, inputSelect, inputColors)

newDeckPage : Model -> Html AppMsg
newDeckPage model =
  div [class "mr-main flex-column flex-start"][
    h4 [][ text ("New Deck") ]
    ,div [class "dialog-large"][
      inputText "name" DeckName
      ,inputText "theme" DeckTheme
      ,inputSelect formats DeckFormat
      ,inputColors DeckTheme
      ,inputText "budget class" DeckTheme
      ,inputText "worth" DeckTheme
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
