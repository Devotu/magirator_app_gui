module Msg exposing (..)

import Navigation
import Json.Decode as JDC exposing (Decoder)
import Phoenix.Socket as Socket exposing (AbnormalClose)
import Request exposing (..)

type AppMsg
    = UrlChange Navigation.Location 
    | NewMsg JDC.Value | DataUpdate JDC.Value 
    | Password String | Username String 
    | SocketConnected | SocketDenied AbnormalClose
    | ChannelAppJoin | ChannelAppJoined JDC.Value | ChannelAppJoinError JDC.Value
    | Navigate String
    | Post Request
    | PostAndNavigate NavRequest
    | NewDeckMsg DeckMsg
    | RegisterMsg RegisterMsg


type DeckMsg
    = Name String | Theme String | Format String
    | ToggleBlack | ToggleWhite | ToggleRed | ToggleGreen | ToggleBlue | ToggleColorless
    | Budget String | Worth String


type RegisterMsg
    = Comment String
    | PlayerSearchName String