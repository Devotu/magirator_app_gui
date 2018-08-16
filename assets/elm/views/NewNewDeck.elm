module NewNewDeck exposing (..)

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
    case message of
        Msg.Name name ->
            let
                deck = model.deck
                updatedDeck = { deck | name = name }
            in
                ( { model | deck = updatedDeck }, Cmd.none )
    
        Msg.Theme theme ->
            let
                deck = model.deck
                updatedDeck = { deck | theme = theme }
            in
                ( { model | deck = updatedDeck }, Cmd.none )
    
        Msg.Format format ->
            let
                deck = model.deck
                updatedDeck = { deck | format = format }
            in
                ( { model | deck = updatedDeck }, Cmd.none )


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
                inputDeckCheckbox "black" Msg.Theme
                ,inputDeckCheckbox "white" Msg.Theme
                ,inputDeckCheckbox "red" Msg.Theme
                ,inputDeckCheckbox "green" Msg.Theme
                ,inputDeckCheckbox "blue" Msg.Theme
                ,inputDeckCheckbox "colorless" Msg.Theme
            ]
            ,inputDeckText "budget class" Msg.Theme
            ,inputDeckText "worth" Msg.Theme
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

inputDeckCheckbox : String -> (String -> DeckMsg) -> Html AppMsg
inputDeckCheckbox color msg =
    Html.map Msg.NewDeckMsg(
        div [class ("input-checkbox checkbox-" ++ color)][
            input [class "checkbox-hidden", type_ "checkbox", id ("id" ++ color), onInput msg][]
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