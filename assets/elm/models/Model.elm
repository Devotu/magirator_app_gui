module Model exposing (..)

import ConnectionStatus
import Deck
import Navigation
import NewDeckView
import GameResultSet
import RegisterGameView
import Player

type alias Model =
    { channelStatus : ConnectionStatus.ConnectionStatus
    , currentRoute : Navigation.Location
    , deck : Deck.Deck
    , deckList : List Deck.Deck
    , gameList : List GameResultSet.GameResultSet
    , gameRegisterModel : RegisterGameView.RegisterModel
    , newDeck : NewDeckView.DeckModel
    , password : String
    , socketStatus : ConnectionStatus.ConnectionStatus
    , socketUrl : String
    , status : String
    , username : String
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
    { model | newDeck = NewDeckView.initialModel }

