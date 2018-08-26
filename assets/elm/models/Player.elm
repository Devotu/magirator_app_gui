module Player exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)

type alias Player =
    { 
        id : Int
        , name : String
    }


emptyPlayer : Player
emptyPlayer =
    {
        id = 0
        , name = ""
    }


decoder : Decode.Decoder Player
decoder =
    decode Player
        |> required "id" Decode.int
        |> required "name" Decode.string