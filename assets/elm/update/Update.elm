module Update exposing (..)

import Model exposing (..)
import Ms exposing (..)
import ChannelStatus exposing (..)
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

        InitAppChannel ->            
            { model | 
                socketUrl = "ws://localhost:4000/socket/websocket?user=" ++ model.username ++ "&pwd=" ++ model.password
                , status = "initiated"
                , channelStatus = ChannelStatus.ConnectionInitiated
            } ! [] 

        AppChannelInitiated importantMessage ->
            { model | 
                status = "test"
                , channelStatus = ChannelStatus.Connected
            } ! []

        SocketInitated ->
            { model | status = "socket initated" } ! []

        SocketDenied abnormalClose ->
            { model | 
                channelStatus = ChannelStatus.NotConnected
            } ! []

        SendMsg -> 
            let 
                push = 
                Push.init "app:main" "new_msg"
                    |> Push.withPayload (JE.object [( "msg",  JE.string "Pwd" )])
            in
                { model | status = "sending" } ! [ Phoenix.push model.socketUrl push ]