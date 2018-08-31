import Navigation
import Model
import Msg exposing (..)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)
import ConnectionStatus exposing (..)
import Deck exposing (..)
import NewDeckView
import RegisterGameView

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
    { channelStatus = ConnectionStatus.NotConnected
    , currentRoute = location
    , deck = emptyDeck
    , deckList = []
    , gameList = []
    , gameRegisterList = RegisterGameView.initialModel
    , newDeck = NewDeckView.initialModel
    , password = "Hemligt"
    , socketStatus = ConnectionStatus.NotConnected
    , socketUrl = "ws://localhost:4000/socket/websocket"
    , status = "Init"
    , username = "Adam"
    }
    ! []