module Update exposing (..)

import Navigation exposing(..)

import Model exposing (..)
import Msg exposing (..)
import ConnectionStatus exposing (..)
import Subscription exposing (..)
import Updaters exposing (..)
import NewNewDeck

import Json.Encode as JE
import Phoenix
import Phoenix.Push as Push

update : AppMsg -> Model -> ( Model, Cmd AppMsg )
update msg model =
    case msg of
        UrlChange location ->
            { model | currentRoute = location } ! []

        NewMsg payload -> 
            { model | status = toString payload } ! []

        Username username ->            
            { model | username = username } ! []

        Password password ->
            { model | password = password } ! []

        ChannelAppJoin ->            
            { model | channelStatus = ConnectionStatus.Connecting } ! [] 

        ChannelAppJoined importantMessage ->
            { model | channelStatus = ConnectionStatus.Connected } ! [ newUrl("/#/home") ]

        ChannelAppJoinError importantMessage ->
            { model | channelStatus = ConnectionStatus.Refused } ! []

        SocketConnected ->
            { model | socketStatus = ConnectionStatus.Connected } ! []

        SocketDenied abnormalClose ->
            { model | 
                socketStatus = ConnectionStatus.Refused 
                , channelStatus = ConnectionStatus.NotConnected
            } ! []
        
        Navigate page ->
            { model | channelStatus = ConnectionStatus.Connected } ! [ newUrl("/#/" ++ page) ]
        
        Post request -> 
        let 
            push = 
                Push.init (appChannel model) request.action
                    |> Push.withPayload ( request.object )
        in
            { model | status = "posting" } ! [ Phoenix.push model.socketUrl push ]

        DeckName name ->
            updateDeck (NewName name) model ! []

        DeckTheme theme ->
            updateDeck (NewTheme theme) model ! []

        DeckFormat format ->
            updateDeck (NewFormat format) model ! []

        NewDeckMsg subMsg ->
            let
                ( updatedNewDeck, deckCmd ) =
                    NewNewDeck.update subMsg model.newDeck
            in
                ( { model | newDeck = updatedNewDeck } , Cmd.none )