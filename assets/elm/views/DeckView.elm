module DeckView exposing (..)

import Deck
import ErrorView
import GameResultSet
import Html exposing (Html, button, div, fieldset, h4, li, ol, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Json.Encode exposing (int)
import Model exposing (Model)
import Msg exposing (AppMsg)
import Request


page : Int -> Model -> String -> Html AppMsg
page deckId model page =

    let
        maybeDeck =
            model.deckList
                |> List.filter (\deck -> deck.id == deckId)
                |> List.head
    in
        case maybeDeck of
            Just deck ->
                    case page of
                        "info" ->
                            deckView deck (deckInfoView deck)
                    
                        "games" ->
                            let
                                games =
                                    model.gameList
                                        |> List.filter (\game -> game.deck.id == deckId)
                            in
                                deckView deck (gamesView games)

                        _ -> 
                            ErrorView.notFoundPage model

            Nothing ->
                ErrorView.notFoundPage model
    


deckView : Deck.Deck -> Html AppMsg -> Html AppMsg
deckView deck tabContent =
     div [class "mr-main flex-column flex-start"][
        h4 [][ text (deck.name) ]
        , tabContent        
        ,div [class "dialog-large split-choice"][
            button [class "input", onClick (Msg.Navigate("deck/" ++ toString deck.id )) ][
            text ("Info")
            ]
            ,button [class "input", onClick (Msg.PostAndNavigate (gamesListRequest deck.id)) ][
            text ("Games")
            ]
            ,button [class "input", onClick (Msg.Navigate("addgame/" ++ toString deck.id)) ][
            text ("+Game")
            ]
        ]
        ,div [class "dialog-large split-choice"][
            button [class "input half-width", onClick ( Msg.Navigate("home") ) ][ 
                text ("Home") 
            ]
        ]
    ]


deckInfoView : Deck.Deck -> Html AppMsg
deckInfoView deck =
    div [class "dialog-large"][
        deckText "Name" deck.name
        ,deckText "Theme" deck.theme
        ,deckText "Format" deck.format
        ,fieldset [class "color-box"][
            deckColor "black" deck.black
            ,deckColor "white" deck.white
            ,deckColor "red" deck.red
            ,deckColor "green" deck.green
            ,deckColor "blue" deck.blue
            ,deckColor "colorless" deck.colorless
        ]
        ,deckText "budget ($)" (toString deck.budget)
        ,deckText "worth ($)" (toString deck.worth)
    ]


gamesView : List GameResultSet.GameResultSet -> Html AppMsg
gamesView games =
    div [class "dialog-large"][
        div [class "list"][
            renderGameList games
        ]
    ]

renderGameList : List GameResultSet.GameResultSet -> Html AppMsg
renderGameList games =
    if List.isEmpty games then
        text "No games played"
    else 
        games 
            |> List.map ( \game -> listGame game )
            |> ol [ class "deck-list" ]


listGame : GameResultSet.GameResultSet -> Html AppMsg
listGame set = 
    let
        game = set.game
        path = "game/" ++ (toString game.id)
    in
    
    li [ class ("deck-list-item " ++ resultColorClass set), onClick (Msg.Navigate path) ][
        text (toString game.id)
    ]


resultColorClass : GameResultSet.GameResultSet -> String
resultColorClass set =
    let
        result = set.result
    in
        case result.place of
            0 ->
                "white dim"

            1 ->
                "green dim"
        
            2 ->
                "red dim"   

            _ ->
                "colorless dim"


gamesListRequest : Int -> Request.NavRequest
gamesListRequest id =
    {
        action = "deck:games"
        , object = Json.Encode.object [
           ("deck_id", int id)
        ]
        , path = "deck/" ++ toString id ++ "/games"
        , reset = ""
    }


deckText : String -> String -> Html none
deckText title info =
    div [][
      span [ class "text-title"][ text (title ++ ": ") ]
      , text info
    ]

deckColor : String -> Bool -> Html AppMsg
deckColor color status =
  if status then
    div [ class ("mana-box used " ++ color ) ][]
  else 
    div [ class ("mana-box dim " ++ color) ] []