module Ms exposing (..)

import Navigation
import Json.Decode as JDC exposing (Decoder)
import Phoenix.Socket as Socket exposing (AbnormalClose)
import Request exposing (..)
import NewNewDeck

type Msg
    = UrlChange Navigation.Location 
    | NewMsg JDC.Value 
    | Password String | Username String 
    | SocketConnected | SocketDenied AbnormalClose
    | ChannelAppJoin | ChannelAppJoined JDC.Value | ChannelAppJoinError JDC.Value
    | Navigate String
    | Post Request
    | DeckName String | DeckTheme String | DeckFormat String
    | NewDeckMsg NewNewDeck.DeckMsg