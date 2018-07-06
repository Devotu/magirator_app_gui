import Navigation

import Model exposing (Model)
import Ms exposing (Msg)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import ConnectionStatus exposing (..)

main : Program Never Model Msg
main =
    Navigation.program Ms.UrlChange
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    { currentRoute = location
    , username = "x"
    , password = "y"
    , socketUrl = "ws://localhost:4000/socket/websocket"
    , socketStatus = ConnectionStatus.NotConnected
    , channelStatus = ConnectionStatus.NotConnected
    , status = "Init"
    }
    ! []