module Subscription exposing (..)

import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel

import ConnectionStatus exposing (..)
import Model exposing (..)
import Msg exposing (..)

import Json.Decode as Decode
import Json.Decode.Pipeline exposing (required, decode)

import Deck
import GameResultSet
import RegisterGameView exposing (RegisterModel)
import Player

socket : Model -> Socket.Socket AppMsg
socket model =
  Socket.init model.socketUrl
    |> Socket.withParams[ ("user", model.username), ("pwd", model.password) ]
    |> Socket.onOpen SocketConnected
    |> Socket.onAbnormalClose SocketDenied

appChannel : Model -> String
appChannel model =
  "app:" ++ model.username

channel : Model -> Channel.Channel AppMsg
channel model =
  Channel.init (appChannel model)
    |> Channel.on "new_msg" NewMsg
    |> Channel.on "data" DataUpdate
    |> Channel.onJoin ChannelAppJoined
    |> Channel.onJoinError ChannelAppJoinError


subscriptions : Model -> Sub AppMsg
subscriptions model =
  if
    model.channelStatus == Connecting || model.channelStatus == Connected 
  then 
      Phoenix.connect (socket model) [channel model]
  else 
    Sub.none


type alias DataPackage = 
  { data : Decode.Value
  , description : String
  }


dataParser : Decode.Decoder DataPackage
dataParser =
    decode DataPackage
        |> required "data" Decode.value
        |> required "description" Decode.string


replaceWithFetched : DataPackage -> Model -> Model
replaceWithFetched content model =
    case content.description of
        "deck:list" ->
            let
                deckResult = Decode.decodeValue (Decode.list Deck.decoder) content.data
            in
                case deckResult of
                  Ok decks ->
                    { model | deckList = decks }
                  Err error ->
                    { model | status = error }


        "deck:games" ->
            let
                gamesResult = Decode.decodeValue (Decode.list GameResultSet.decoder) content.data
            in
                case gamesResult of
                  Ok gameResults ->
                    { model | gameList = gameResults }
                  Err error ->
                    { model | status = error }


        "player:search" ->
            let
                players = Decode.decodeValue (Decode.list Player.decoder) content.data
                registerModel = model.gameRegisterModel
            in
                case players of
                    Ok players ->
                      { model | gameRegisterModel = insertSearchedPlayers model.gameRegisterModel players }
                    Err error ->
                      { model | status = error }
    
        _ ->
          { model | status = "replaceWithFetched not found" }


insertSearchedPlayers : RegisterModel -> List Player.Player -> RegisterModel
insertSearchedPlayers registerModel players =
  { registerModel | playerSearchList = players }
