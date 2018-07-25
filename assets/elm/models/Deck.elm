module Deck exposing (..)

import Json.Encode exposing (..)

type alias Deck =
    { id : Int
    , name : String
    , theme : String
    }

emptyDeck : Deck
emptyDeck =
    {
        id = 0
        , name = "blank"
        , theme = "none yet"
    }