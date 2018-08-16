module NewDeck exposing (..)

import Deck
import Json.Encode exposing (string)
import Html exposing (Html, button, fieldset, input, div, text, select, label, h4, option)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (class, placeholder, type_, for, id, value)
import Msg exposing(AppMsg, DeckMsg)
import Request


-- MODEL

type alias Model =
    { deck : Deck.Deck
    }


initialDeck : Model
initialDeck =
    { deck = Deck.emptyDeck
    }


-- MESSAGES
-- Msg.DeckMsg


-- UPDATE

update : DeckMsg -> Model -> ( Model, Cmd DeckMsg )
update message model =
    let
        deck = model.deck
    in
        case message of
            Msg.Name val ->
                let
                    updatedDeck = { deck | name = val }
                in
                    setUpdated updatedDeck model
        
            Msg.Theme val ->
                let
                    updatedDeck = { deck | theme = val }
                in
                    setUpdated updatedDeck model
        
            Msg.Format val ->
                let
                    updatedDeck = { deck | format = val }
                in
                    setUpdated updatedDeck model
        
            Msg.ToggleBlack ->
                let
                    updatedDeck = { deck | black = not deck.black }
                in
                    setUpdated updatedDeck model
        
            Msg.ToggleWhite ->
                let
                    updatedDeck = { deck | white = not deck.white }
                in
                    setUpdated updatedDeck model
        
            Msg.ToggleRed ->
                let
                    updatedDeck = { deck | red = not deck.red }
                in
                    setUpdated updatedDeck model
        
            Msg.ToggleGreen ->
                let
                    updatedDeck = { deck | green = not deck.green }
                in
                    setUpdated updatedDeck model
        
            Msg.ToggleBlue ->
                let
                    updatedDeck = { deck | blue = not deck.blue }
                in
                    setUpdated updatedDeck model
        
            Msg.ToggleColorless ->
                let
                    updatedDeck = { deck | colorless = not deck.colorless }
                in
                    setUpdated updatedDeck model
        
            Msg.Budget val ->
                let
                    updatedDeck = { deck | budget = val }
                in
                    setUpdated updatedDeck model
        
            Msg.Worth val ->
                let
                    updatedDeck = { deck | worth = val }
                in
                    setUpdated updatedDeck model


setUpdated : Deck.Deck -> Model -> ( Model, Cmd DeckMsg )
setUpdated deck model =
    ( { model | deck = deck }, Cmd.none )


-- VIEW 

view : Model -> Html AppMsg
view model =
    let
        deck = model.deck
    in
        div [class "mr-main flex-column flex-start"][
            h4 [][ text ("New Deck") ]
            ,div [class "dialog-large"][
            inputDeckText "name" Msg.Name
            ,inputDeckText "theme" Msg.Theme
            ,inputDeckSelect Deck.formats Msg.Format
            ,fieldset [class "color-box"][
                inputDeckCheckbox "black" Msg.ToggleBlack
                ,inputDeckCheckbox "white" Msg.ToggleWhite
                ,inputDeckCheckbox "red" Msg.ToggleRed
                ,inputDeckCheckbox "green" Msg.ToggleGreen
                ,inputDeckCheckbox "blue" Msg.ToggleBlue
                ,inputDeckCheckbox "colorless" Msg.ToggleColorless
            ]
            ,inputDeckText "budget class ($)" Msg.Budget
            ,inputDeckText "worth ($)" Msg.Worth
            ,div [class "split-choice"][
                button [class "input half-width", onClick ( Msg.Navigate("home") ) ][ text ("Back") ]
                ,button [class "input half-width", onClick ( Msg.Post (newDeck model) ) ][ text ("Create") ]
            ]
            ]
        ]


inputDeckText : String -> (String -> DeckMsg) -> Html AppMsg
inputDeckText ph msg =
    Html.map Msg.NewDeckMsg( 
        input [class "input input-text", placeholder ph, type_ "text", onInput msg][ ] 
    )

inputDeckSelect : List String -> (String -> DeckMsg) -> Html AppMsg
inputDeckSelect list msg =
    Html.map Msg.NewDeckMsg( 
        select [ onInput msg ] (List.map stringToOption list)
    )

inputDeckCheckbox : String -> DeckMsg -> Html AppMsg
inputDeckCheckbox color msg =
    Html.map Msg.NewDeckMsg(
        div [class ("input-checkbox checkbox-" ++ color)][
            input [class "checkbox-hidden", type_ "checkbox", id ("id" ++ color), onClick msg][]
            ,label [class "checkbox-color-label", for ("id" ++ color) ][]
        ]
    )

stringToOption : String -> Html DeckMsg
stringToOption s =
  option [ value s ] [ text s ]


-- DATA TRANSFORM

newDeck : Model -> Request.Request
newDeck model =
  let 
    deck = model.deck
  in
  {
    action = "deck:create"
    , object = Json.Encode.object [
      ("name", string deck.name)
      , ("theme", string deck.theme)
    ]
  }