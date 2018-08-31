module Update exposing (..)

import Navigation exposing(..)

import Model exposing (..)
import Msg exposing (..)
import ConnectionStatus exposing (..)
import Subscription exposing (..)
import Phoenix
import Phoenix.Push as Push
import Json.Decode as Decode

import NewDeckView
import RegisterGameView

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

        
        Post request -> 
        let 
            push = 
                Push.init (appChannel model) request.action
                    |> Push.withPayload ( request.object )
        in
            { model | status = "posting" } ! [ Phoenix.push model.socketUrl push ]

        
        Navigate page ->
            { model | channelStatus = ConnectionStatus.Connected } ! [ newUrl("/#/" ++ page) ]


        PostAndNavigate request ->
            let 
                push = 
                    Push.init (appChannel model) request.action
                        |> Push.withPayload ( request.object )
                
                resetModel = Model.resetTargetInput request.reset model
                        
            in
                { resetModel | status = "posting and navigating" } ! [ Phoenix.push model.socketUrl push, newUrl("/#/" ++ request.path) ]


        NewDeckMsg subMsg ->
            let
                ( updatedNewDeck, deckCmd ) =
                    NewDeckView.update subMsg model.newDeck
            in
                ( { model | newDeck = updatedNewDeck } , Cmd.none )


        RegisterMsg subMsg ->
            let
                ( updatedRegisterList, registerCmd ) =
                    RegisterGameView.update subMsg model.gameRegisterModel
            in
                ( { model | gameRegisterModel = updatedRegisterList } , Cmd.none )

            
        DataUpdate payload -> 
            let
                parsedPayloadResult = Decode.decodeValue Subscription.dataParser payload
            in
                case parsedPayloadResult of
                    Ok json ->
                        Subscription.replaceWithFetched json model ! []
                
                    Err error ->
                        { model | status = toString error } ! []