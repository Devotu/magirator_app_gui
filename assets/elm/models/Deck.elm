module Deck exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)

type alias Deck =
    { 
        id : Int
        , name : String
        , theme : String
        , format : String
        , black : Bool
        , white : Bool
        , red : Bool
        , green : Bool
        , blue : Bool
        , colorless : Bool
        , budget : Float
        , worth : Float
    }


emptyDeck : Deck
emptyDeck =
    {
        id = 0
        , name = ""
        , theme = ""
        , format = "None"
        , black = False
        , white = False
        , red = False
        , green = False
        , blue = False
        , colorless = False
        , budget = 0
        , worth = 0
    }


formats : List String
formats
    = ["None", "Standard", "Modern"]


decoder : Decode.Decoder Deck
decoder =
    decode Deck
        |> required "id" Decode.int
        |> required "name" Decode.string
        |> required "theme" Decode.string
        |> required "format" Decode.string
        |> required "black" Decode.bool
        |> required "white" Decode.bool
        |> required "red" Decode.bool
        |> required "green" Decode.bool
        |> required "blue" Decode.bool
        |> required "colorless" Decode.bool
        |> optional "budget" Decode.float 0
        |> optional "worth" Decode.float 0