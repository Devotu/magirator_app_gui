module NewNewDeck exposing (..)

import Deck
import Html exposing (Html, input, div, text)
import Html.Events exposing (onInput)
import Html.Attributes exposing (class, placeholder, type_)


-- MODEL


type alias Model =
    { deck : Deck.Deck
    }


initialDeck : Model
initialDeck =
    { deck = Deck.emptyDeck
    }



-- MESSAGES


type DeckMsg
    = Name String 
    | Theme String 
    | Format String



-- VIEW


view : Model -> Html DeckMsg
view model =
    let
        deck = model.deck
    in
        
    div []
        [
            input [class "input input-text", placeholder deck.name, type_ "text", onInput Name][ ]
        ]



-- UPDATE


update : DeckMsg -> Model -> ( Model, Cmd DeckMsg )
update message model =
    case message of
        Name name ->
            let
                deck = model.deck
                updatedDeck = { deck | name = name }
            in
                ( { model | deck = updatedDeck }, Cmd.none )
    
        Theme theme ->
            let
                deck = model.deck
                updatedDeck = { deck | theme = theme }
            in
                ( { model | deck = updatedDeck }, Cmd.none )
    
        Format format ->
            let
                deck = model.deck
                updatedDeck = { deck | format = format }
            in
                ( { model | deck = updatedDeck }, Cmd.none )