import Navigation
import Model
import Ms exposing (Msg)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import ConnectionStatus exposing (..)
import Deck exposing (..)
import NewNewDeck

main : Program Never Model.Model Msg
main =
    Navigation.program Ms.UrlChange
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : Navigation.Location -> ( Model.Model, Cmd Msg )
init location =
    { currentRoute = location
    , username = "x"
    , password = "y"
    , socketUrl = "ws://localhost:4000/socket/websocket"
    , socketStatus = ConnectionStatus.NotConnected
    , channelStatus = ConnectionStatus.NotConnected
    , status = "Init"
    , deck = emptyDeck
    , newDeck = NewNewDeck.initialDeck
    }
    ! []