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
    , worth : Float
    , budget : Int
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