module Request exposing (..)

import Json.Encode exposing (..)

type alias Request =
    { action : String
    ,object : Json.Encode.Value
    }