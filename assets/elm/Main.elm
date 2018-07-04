import Navigation

import Model exposing (Model)
import Ms exposing (Msg)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import ChannelStatus exposing (..)

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
    , username = "aaa"
    , password = "bbb"
    , credentials = { username = "xxx", password = "yyy" }
    , socketUrl = "ws://localhost:4000/socket/websocket"
    , channelStatus = ChannelStatus.NotConnected
    , status = "Not initiated"
    }
    ! []