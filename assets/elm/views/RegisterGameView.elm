module RegisterGameView exposing (..)

import Html exposing (Html, button, div, h4, input, text, li, ol, option, select)
import Html.Attributes exposing (class, type_, placeholder, value)
import Html.Events exposing (onClick, onInput)
import Json.Encode exposing (string)
import Msg exposing (AppMsg, RegisterMsg)

import GameRegisterResult 
import Request
import Player

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



initiateResults : RegisterModel -> Int -> RegisterModel
initiateResults model deckId =
    let
        hash = (toString deckId) ++ "to be timestamp"
    in
        { model | results = [ GameRegisterResult.newGameRegisterResult deckId "deckName" hash 1 "Me" ] }

-- VIEW 

page : RegisterModel -> Int -> Html AppMsg
page model deckId = 
    let
        initatedModel = initiateResults model deckId
    in        
        div [class "mr-main flex-column flex-start"][
            h4 [][ text ( "Game " ++ initatedModel.comment ) ]
            ,Html.map Msg.RegisterMsg( 
                input [class "input input-text", placeholder "Comment", type_ "text", onInput Msg.Comment][ ] 
            )
            ,Html.map Msg.RegisterMsg( 
                input [class "input input-text", placeholder "Search player", type_ "text", onInput Msg.PlayerSearchName ][ ] 
            )
            ,button [class "input half-width", onClick ( Msg.Post (playerSearchRequest initatedModel) ) ][ text ("Search") ]
            ,initatedModel.playerSearchList
                |> List.map ( \player -> listPlayer player )
                |> ol [ class "deck-list" ]
            ,inputRegisterSelect ["test","kalle"] Msg.Comment
            ,initatedModel.results
                |> List.map ( \result -> listPlace result )
                |> ol [ class "deck-list" ]
        ]


listPlace : GameRegisterResult.GameRegisterResult -> Html AppMsg
listPlace result =     
    li [ class ("deck-list-item") ][
        text ( (toString result.place) ++ ": " ++ result.playerName )
    ]

listPlayer : Player.Player -> Html AppMsg
listPlayer player =     
    li [ class ("deck-list-item") ][
        text ( player.name )
    ]


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