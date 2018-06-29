module Model exposing (..)

import Navigation exposing (..)

import Credentials exposing (..)

type alias Model =
    { currentRoute : Navigation.Location
    ,credentials : Credentials
    ,socketUrl : String
    ,status : String
    }