module Model exposing (..)

import ConnectionStatus
import Deck
import Navigation
import NewDeckView
import GameResultSet

type alias Model =
    { currentRoute : Navigation.Location
    , username : String
    , password : String
    , socketUrl : String
    , socketStatus : ConnectionStatus.ConnectionStatus
    , channelStatus : ConnectionStatus.ConnectionStatus
    , status : String
    , deck : Deck.Deck
    , newDeck : NewDeckView.Model
    , deckList : List Deck.Deck
    , gameList : List GameResultSet.GameResultSet
    }


resetTargetInput : String -> Model -> Model
resetTargetInput target model =
    case target of
        "newDeck" ->
            resetNewDeck model
    
        _ ->
            model


resetNewDeck : Model -> Model
resetNewDeck model =
    { model | newDeck = NewDeckView.initialDeck }
