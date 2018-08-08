module Updaters exposing (..)

import Model exposing (..)
import Ms exposing (..)

noCmd : Model -> ( Model, Cmd Msg )
noCmd model =
    ( model, Cmd.none )

type DeckMsg
    = Name String
    | Theme String

updateDeck : DeckMsg -> Model -> Model
updateDeck dmsg model =
    case dmsg of
        Name name->
            let
                deck = model.deck
                newDeck = { deck | name = name }
            in
                { model | deck = newDeck }
    
        Theme theme ->
            let
                deck = model.deck
                newDeck = { deck | theme = theme }
            in
                { model | deck = newDeck }