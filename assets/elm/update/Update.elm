module Update exposing (..)

import Model exposing (..)
import Ms exposing (..)

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
          { model | currentRoute = location } ! []

        NewMsg payload -> 
        { model | status = toString payload } ! []

        Password password ->
        { model | password = password } ! []

        Username username -> 
        { model | username = username } ! []

        SendMsg -> 
        -- let 
        --     push = 
        --     Push.init "app:main" "new_msg"
        --         |> Push.withPayload (JE.object [( "msg",  JE.string model.password )])
        -- in
            { model | status = "sending" } ! [] -- Phoenix.push mainSocket push ]