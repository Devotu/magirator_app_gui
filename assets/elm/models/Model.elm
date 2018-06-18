module Model exposing (..)

import Navigation exposing (..)

type alias Model =
    { currentRoute : Navigation.Location
    ,username : String
    ,password : String
    ,status : String
    }