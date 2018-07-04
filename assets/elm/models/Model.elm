module Model exposing (..)

import Navigation exposing (..)
import ChannelStatus exposing (..)

import Credentials exposing (..)

type alias Model =
    { currentRoute : Navigation.Location
    , username : String
    , password : String
    , credentials : Credentials
    , socketUrl : String
    , channelStatus : ChannelStatus
    , status : String
    }