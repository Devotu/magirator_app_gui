module Msg exposing (..)

import Navigation
import Json.Decode as JDC exposing (Decoder)
import Phoenix.Socket as Socket exposing (AbnormalClose)
import Request exposing (..)

type AppMsg
    = UrlChange Navigation.Location 
    | NewMsg JDC.Value 
    | Password String | Username String 
    | SocketConnected | SocketDenied AbnormalClose
    | ChannelAppJoin | ChannelAppJoined JDC.Value | ChannelAppJoinError JDC.Value
    | Navigate String
    | Post Request
    | DeckName String | DeckTheme String | DeckFormat String
    | NewDeckMsg DeckMsg


type DeckMsg
    = Name String 
    | Theme String 
    | Format String