module GameView exposing (..)

import Html exposing (Html, div, h4, li, ol, text)
import Html.Attributes exposing (class)
import Msg exposing (AppMsg)
import Model exposing (Model)
import Maybe exposing (Maybe)
import GameResultSet


page : Model -> Int -> Html AppMsg
page model gameId =  
    div [class "mr-main flex-column flex-start"][
        h4 [][ text ( "Game" ++ toString(gameId) ) ]
        ,model.gameList
            |> List.filter (\result -> result.game.id == gameId)
            |> List.sortWith sortPlaces 
            |> List.map ( \result -> listPlace result )
            |> ol [ class "deck-list" ]
  ]


listPlace : GameResultSet.GameResultSet -> Html AppMsg
listPlace set = 
    let
        result = set.result
        player = set.player
    in
    
    li [ class ("deck-list-item") ][
        text ( (toString result.place) ++ ": " ++ player.name )
    ]


sortPlaces : GameResultSet.GameResultSet -> GameResultSet.GameResultSet -> Order
sortPlaces setA setB = 
    let
        resultA = setA.result
        resultB = setB.result
    in
        case compare resultA.place resultB.place of
            LT -> LT
            EQ -> EQ
            GT -> GT