module Model exposing (..)

import Navigation exposing (..)
import ConnectionStatus exposing (..)
import Deck exposing (..)


type alias Model =
    { currentRoute : Navigation.Location
    , username : String
    , password : String
    , socketUrl : String
    , socketStatus : ConnectionStatus
    , channelStatus : ConnectionStatus
    , status : String
    , newDeck : Deck
    }