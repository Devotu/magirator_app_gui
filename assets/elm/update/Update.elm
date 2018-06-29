module Update exposing (..)

import Model exposing (..)
import Ms exposing (..)
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

        Password password ->
            let
                currentCredentials = model.credentials
                newCredentials = { currentCredentials | password = password }
            in
                { model | credentials = newCredentials } ! []

        Username username ->            
            let
                currentCredentials = model.credentials
                newCredentials = { currentCredentials | username = username }
            in             
                { model | credentials = newCredentials } ! []

        SendMsg -> 
            let 
                push = 
                Push.init "app:main" "new_msg"
                    |> Push.withPayload (JE.object [( "msg",  JE.string "Pwd" )])
            in
                { model | status = "sending" } ! [ Phoenix.push (mainSocketUrl model) push ]