module DeckList exposing (..)

import Html exposing (Html, button, div, h4, li, ol, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import Model exposing (Model)
import Msg exposing (AppMsg)
import Deck


page : Model -> Html AppMsg
page model =
    div [class "mr-main flex-column flex-start"][
        h4 [][ text ("Decks") ]
        ,div [class "dialog-large"][
            div [class "list"][
                renderDeckList model.deckList
                -- ol [][text "test1"]
                -- ,ol [][text "test2"]
            ]
            ,div [class "split-choice"][
                button [class "input half-width", onClick ( Msg.Navigate("home") ) ][ 
                    text ("Back") 
                ]
                ,button [class "input", onClick (Msg.Navigate("newdeck")) ][
                    text ("New")
                ]
            ]
        ]
    ]

renderDeckList : List Deck.Deck -> Html AppMsg
renderDeckList decks =
    decks 
        |> List.map ( \deck -> listDeck deck )
        |> ol [ class "deck-list" ]


listDeck : Deck.Deck -> Html AppMsg
listDeck deck = 
    let
        path = "deck/" ++ (toString deck.id)
    in        
        li [ class "deck-list-item", onClick( Msg.Navigate(path) ) ][
            text deck.name
        ]