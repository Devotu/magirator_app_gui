module Deck exposing (..)

type alias Deck =
    { id : Int
    , name : String
    , theme : String
    , format : String
    , black : Bool
    , white : Bool
    , red : Bool
    , green : Bool
    , blue : Bool
    , colorless : Bool
    }

emptyDeck : Deck
emptyDeck =
    {
        id = 0
        , name = ""
        , theme = ""
        , format = "Standard"
        , black = False
        , white = False
        , red = False
        , green = False
        , blue = False
        , colorless = False
    }