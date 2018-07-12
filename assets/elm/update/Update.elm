module Update exposing (..)

import Model exposing (..)
import Ms exposing (..)
import ConnectionStatus exposing (..)
import Subscription exposing (..)

import Json.Encode as JE
import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push

update : Msg -> Model -> ( Model, Cmd Msg )
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
            { model | channelStatus = ConnectionStatus.Connected } ! []

        ChannelAppJoinError importantMessage ->
            { model | channelStatus = ConnectionStatus.Refused } ! []

        SocketConnected ->
            { model | socketStatus = ConnectionStatus.Connected } ! []

        SocketDenied abnormalClose ->
            { model | 
                socketStatus = ConnectionStatus.Refused 
                , channelStatus = ConnectionStatus.NotConnected
            } ! []

        SendMsg -> 
        let 
            push = 
                Push.init "app:user" "new_msg"
                    |> Push.withPayload (JE.object [( "msg",  JE.string "Messaget" )])
        in
            { model | status = "sending" } ! [ Phoenix.push model.socketUrl push ]