module RegisterGameView exposing (..)

import Html exposing (Html, div, h4, input, text, li, ol)
import Html.Attributes exposing (class, type_, placeholder)
import Html.Events exposing (onInput)
import Msg exposing (AppMsg, RegisterMsg)

import GameRegisterResult 

-- MODEL

type alias RegisterModel =
    { comment : String
    , results : List GameRegisterResult.GameRegisterResult
    }


initialModel : RegisterModel
initialModel =
    { comment = ""
    , results = []
    }


-- MESSAGES
-- Msg.GameMsg


-- UPDATE

update : RegisterMsg -> RegisterModel -> ( RegisterModel, Cmd RegisterMsg )
update message model =
    case message of
        Msg.Comment val ->
            ( { model | comment = val } ! [ Cmd.none ] )


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
            ,initatedModel.results
                |> List.map ( \result -> listPlace result )
                |> ol [ class "deck-list" ]
        ]


listPlace : GameRegisterResult.GameRegisterResult -> Html AppMsg
listPlace result =     
    li [ class ("deck-list-item") ][
        text ( (toString result.place) ++ ": " ++ result.playerName )
    ]