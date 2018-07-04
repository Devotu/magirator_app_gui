module Ms exposing (..)

import Navigation
import Json.Decode as JDC exposing (Decoder)
import Phoenix.Socket as Socket exposing ( AbnormalClose)

type Msg
    = UrlChange Navigation.Location | NewMsg JDC.Value | Password String | SendMsg | Username String | 
    SocketInitated | SocketDenied AbnormalClose | InitAppChannel | AppChannelInitiated JDC.Value