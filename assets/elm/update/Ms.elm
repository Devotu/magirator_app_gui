module Ms exposing (..)

import Navigation
import Json.Decode as JDC exposing (Decoder)
import Json.Encode exposing (..)
import Phoenix.Socket as Socket exposing ( AbnormalClose)

type Msg
    = UrlChange Navigation.Location 
    | NewMsg JDC.Value 
    | Password String | Username String 
    | SocketConnected | SocketDenied AbnormalClose
    | ChannelAppJoin | ChannelAppJoined JDC.Value | ChannelAppJoinError JDC.Value
    | SendMsg
    | Navigate String
    | Post Json.Encode.Value