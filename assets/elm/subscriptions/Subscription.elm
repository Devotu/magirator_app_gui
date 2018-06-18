module Subscription exposing (..)

import Model exposing (..)
import Ms exposing (..)

subscriptions : Model -> Sub Ms.Msg
subscriptions model =
  Sub.none