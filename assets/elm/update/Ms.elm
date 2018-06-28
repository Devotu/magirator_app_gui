module Ms exposing (..)

import Navigation
import String
import List exposing (..)
import Json.Decode as JDC exposing (Decoder)

type Msg
    = UrlChange Navigation.Location | NewMsg JDC.Value | Password String | SendMsg | Username String