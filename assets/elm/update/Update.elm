module Update exposing (..)

import Navigation exposing(..)

import Model exposing (..)
import Ms exposing (..)
import ConnectionStatus exposing (..)
import Subscription exposing (..)

import Json.Encode as JE
import Phoenix
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

        SendMsg -> 
        let 
            push = 
                Push.init (appChannel model) "new_msg"
                    |> Push.withPayload (JE.object [( "msg",  JE.string "Messaget" )])
        in
            { model | status = "sending" } ! [ Phoenix.push model.socketUrl push ]
        
        Navigate page ->
            { model | channelStatus = ConnectionStatus.Connected } ! [ newUrl("/#/" ++ page) ]
        
        Post request -> 
        let 
            push = 
                Push.init (appChannel model) request.endpoint
                    |> Push.withPayload ( request.object )
        in
            { model | status = "posting" } ! [ Phoenix.push model.socketUrl push ]