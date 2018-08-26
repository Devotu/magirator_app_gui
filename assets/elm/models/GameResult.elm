module GameResult exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)

type alias GameResult =
    { 
        id : Int
        , place : Int
        , comment : String
    }


emptyGameResult : GameResult
emptyGameResult =
    {
        id = 0
        , place = 0
        , comment = ""
    }


decoder : Decode.Decoder GameResult
decoder =
    decode GameResult
        |> required "id" Decode.int
        |> required "place" Decode.int
        |> required "comment" Decode.string