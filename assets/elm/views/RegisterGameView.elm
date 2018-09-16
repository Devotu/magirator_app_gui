module RegisterGameView exposing (..)

import Html exposing (Html, button, div, h4, input, text, li, ol, option, select)
import Html.Attributes exposing (class, type_, placeholder, value)
import Html.Events exposing (onClick, onInput)
import Json.Encode exposing (string)
import Msg exposing (AppMsg, RegisterMsg)

import GameRegisterResult 
import Request
import Player
import Deck

-- MODEL

type alias RegisterModel =
    { comment : String
    , playerSearchList : List Player.Player
    , results : List GameRegisterResult.GameRegisterResult
    , searchPlayer : String
    }


initialModel : RegisterModel
initialModel =
    { comment = ""
    , playerSearchList = []
    , results = []
    , searchPlayer = ""
    }


initiateModel : Int -> RegisterModel
initiateModel deckId =
    let
        initiatedModel = initialModel
    in
        { initiatedModel | results = [ GameRegisterResult.newGameRegisterResult deckId "deckName" "hash" 1 0 "Me" ] }
    

-- MESSAGES
-- Msg.GameMsg


-- UPDATE

update : RegisterMsg -> RegisterModel -> ( RegisterModel, Cmd RegisterMsg )
update message model =
    case message of

        Msg.Comment val ->
            ( { model | comment = val } ! [ Cmd.none ] )

        Msg.PlayerSearchName name ->
            ( { model | searchPlayer = name } ! [ Cmd.none ] )

        Msg.AddPlayer player ->
            let
                place = List.length model.results +1
                hash = player.name ++ (toString place)    
                playerResult = GameRegisterResult.newGameRegisterResult 0 "not selected" hash place player.id player.name
                updatedResults = playerResult::model.results
            in
                { model | results = updatedResults } ! [ Cmd.none ]



-- VIEW 

page : RegisterModel -> Int -> Html AppMsg
page model deckId =       
    div [class "mr-main flex-column flex-start"][
        h4 [][ text ( "Game " ++ model.comment ) ]
        ,Html.map Msg.RegisterMsg( 
            input [class "input input-text", placeholder "Comment", type_ "text", onInput Msg.Comment][ ] 
        )
        ,Html.map Msg.RegisterMsg( 
            input [class "input input-text", placeholder "Search player", type_ "text", onInput Msg.PlayerSearchName ][ ] 
        )
        ,button [class "input half-width", onClick ( Msg.Post (playerSearchRequest model) ) ][ 
            text ("Search") 
        ]
        ,model.playerSearchList
            |> List.map ( \player -> listPlayer model player )
            |> ol [ class "deck-list" ]
        ,model.results
            |> List.map ( \result -> listPlace result )
            |> ol [ class "deck-list" ]
        ]


listPlace : GameRegisterResult.GameRegisterResult -> Html AppMsg
listPlace result =     
    li [ class ("deck-list-item") ][
        text ( (toString result.place) ++ ": " ++ result.playerName )
    ]

listPlayer : RegisterModel -> Player.Player -> Html AppMsg
listPlayer model player =
    Html.map Msg.RegisterMsg( 
        li [ class ("deck-list-item") ][
            text ( player.name )
            ,button [class "input half-width", onClick ( Msg.AddPlayer player ) ][ 
                text ("Add")
            ]
        ]
    )


inputRegisterSelect : List String -> (String -> RegisterMsg) -> Html AppMsg
inputRegisterSelect list msg =
    Html.map Msg.RegisterMsg( 
        select [ onInput msg ] (List.map stringToOption list)
    )


stringToOption : String -> Html RegisterMsg
stringToOption s =
    option [ value s ] [ text s ]


playerSearchRequest : RegisterModel -> Request.Request
playerSearchRequest model =
    {
        action = "player:search"
        , object = Json.Encode.object [
            ("name", string model.searchPlayer)
        ]
    }