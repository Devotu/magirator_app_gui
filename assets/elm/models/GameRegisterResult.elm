module GameRegisterResult exposing (..)


type alias GameRegisterResult =
    { 
        deckId : Int
        , deckName : String
        , gameHash : String
        , place : Int
        , playerName : String
    }


newGameRegisterResult : Int -> String -> String -> Int -> String -> GameRegisterResult
newGameRegisterResult deckId deckName hash place playerName =
    {
        deckId = deckId
        , deckName = deckName
        , gameHash = hash
        , place = place
        , playerName = playerName
    }