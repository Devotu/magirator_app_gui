module DeckMain exposing (..)

import Deck
import Error
import Html exposing (Html, button, div, fieldset, h4, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Json.Encode
import Model exposing (Model)
import Msg exposing (AppMsg)
import Request


page : Int -> Model -> Html AppMsg
page deckId model =

    let
        maybeDeck =
            model.deckList
                |> List.filter (\deck -> deck.id == deckId)
                |> List.head
    in
        case maybeDeck of
            Just deck ->
                deckView deck

            Nothing ->
                Error.notFoundPage model


deckView : Deck.Deck -> Html AppMsg
deckView deck =
     div [class "mr-main flex-column flex-start"][
        h4 [][ text ("New Deck") ]
        ,div [class "dialog-large"][
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
        ,div [class "dialog-large split-choice"][
            button [class "input", onClick (Msg.Navigate("deck/" ++ toString deck.id )) ][
            text ("Info")
            ]
            ,button [class "input", onClick (Msg.PostAndNavigate (gamesListRequest deck.id)) ][
            text ("Games")
            ]
            ,button [class "input", onClick (Msg.Navigate("deck/" ++ toString deck.id ++ "/stats")) ][
            text ("Stats")
            ]
        ]
    ]


deckInfoView : Deck.Deck -> Html AppMsg
deckInfoView deck =
     div [class "mr-main flex-column flex-start"][
        h4 [][ text ("New Deck") ]
        ,div [class "dialog-large"][
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
        ,div [class "dialog-large split-choice"][
            button [class "input", onClick (Msg.Navigate("deck/" ++ toString deck.id )) ][
            text ("Info")
            ]
            ,button [class "input", onClick (Msg.Navigate("deck/" ++ toString deck.id ++ "/games")) ][
            text ("Games")
            ]
            ,button [class "input", onClick (Msg.Navigate("deck/" ++ toString deck.id ++ "/stats")) ][
            text ("Stats")
            ]
        ]
    ]


gamesListRequest : Int -> Request.NavRequest
gamesListRequest id =
  {
    action = "deck:games"
    , object = Json.Encode.object []
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