module Game exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)

type alias Game =
    { 
        id : Int
        , end : String
    }


emptyGame : Game
emptyGame =
    {
        id = 0
        , end = ""
    }


ends : List String
ends
    = ["Victory", "Draw", "Other"]


decoder : Decode.Decoder Game
decoder =
    decode Game
        |> required "id" Decode.int
        |> required "end" Decode.string