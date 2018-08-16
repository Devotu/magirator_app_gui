module Updaters exposing (..)

import Model exposing (..)
import Msg exposing (..)

noCmd : Model -> ( Model, Cmd AppMsg )
noCmd model =
    ( model, Cmd.none )

type DeckMsg
    = NewName String
    | NewTheme String
    | NewFormat String

updateDeck : DeckMsg -> Model -> Model
updateDeck dmsg model =
    case dmsg of
        NewName name->
            let
                deck = model.deck
                newDeck = { deck | name = name }
            in
                { model | deck = newDeck }
    
        NewTheme theme ->
            let
                deck = model.deck
                newDeck = { deck | theme = theme }
            in
                { model | deck = newDeck }
    
        NewFormat format ->
            let
                deck = model.deck
                newDeck = { deck | format = format }
            in
                { model | deck = newDeck }