module Request exposing (..)

import Json.Encode exposing (..)

type alias Request =
    { action : String
    ,object : Json.Encode.Value
    }

type alias NavRequest =
    { action : String
    ,object : Json.Encode.Value
    ,path : String
    }