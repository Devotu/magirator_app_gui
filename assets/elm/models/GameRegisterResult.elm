module GameRegisterResult exposing (..)


type alias GameRegisterResult =
    { 
        deckId : Int
        , deckName : String
        , gameHash : String
        , place : Int
        , playerId : Int
        , playerName : String
    }


newGameRegisterResult : Int -> String -> String -> Int -> Int -> String -> GameRegisterResult
newGameRegisterResult deckId deckName hash place playerId playerName =
    {
        deckId = deckId
        , deckName = deckName
        , gameHash = hash
        , place = place
        , playerId = playerId
        , playerName = playerName
    }