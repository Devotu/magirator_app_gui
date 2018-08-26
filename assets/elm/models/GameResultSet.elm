module GameResultSet exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (decode, required, optional)

import Deck
import Game
import GameResult
import Player

type alias GameResultSet =
    { 
        game : Game.Game
        , result : GameResult.GameResult
        , deck : Deck.Deck
        , player : Player.Player
    }


decoder : Decode.Decoder GameResultSet
decoder =
    decode GameResultSet
        |> required "game" Game.decoder
        |> required "result" GameResult.decoder
        |> required "deck" Deck.decoder
        |> required "player" Player.decoder