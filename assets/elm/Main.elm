import Navigation
import Model
import Msg exposing (..)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import ConnectionStatus exposing (..)
import Deck exposing (..)
import NewDeck

main : Program Never Model.Model AppMsg
main =
    Navigation.program Msg.UrlChange
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


init : Navigation.Location -> ( Model.Model, Cmd AppMsg )
init location =
    { currentRoute = location
    , username = "Adam"
    , password = "Hemligt"
    , socketUrl = "ws://localhost:4000/socket/websocket"
    , socketStatus = ConnectionStatus.NotConnected
    , channelStatus = ConnectionStatus.NotConnected
    , status = "Init"
    , deck = emptyDeck
    , newDeck = NewDeck.initialDeck
    , deckList = []
    }
    ! []