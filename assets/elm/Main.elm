import Html exposing (..)
import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push
import Json.Encode as JE
import Navigation
import String

import Model exposing (Model)
import Ms exposing (Msg)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)

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
    , credentials = { username = "xxx", password = "yyy" }
    , status = "Not initiated"
    }
    ! []