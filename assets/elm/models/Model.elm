module Model exposing (..)

import ConnectionStatus
import Deck
import Navigation
import NewDeck

type alias Model =
    { currentRoute : Navigation.Location
    , username : String
    , password : String
    , socketUrl : String
    , socketStatus : ConnectionStatus.ConnectionStatus
    , channelStatus : ConnectionStatus.ConnectionStatus
    , status : String
    , deck : Deck.Deck
    , newDeck : NewDeck.Model
    }