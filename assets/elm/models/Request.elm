module Request exposing (..)

import Json.Encode exposing (..)

type alias Request =
    { endpoint : String
    ,object : Json.Encode.Value
    }