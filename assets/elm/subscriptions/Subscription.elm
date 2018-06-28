module Subscription exposing (..)

import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push

import Model exposing (..)
import Ms exposing (..)


mainSocket : String
mainSocket =
  "ws://localhost:4000/socket/websocket?user=Otto&pwd=hemligt"

socket =
  Socket.init mainSocket

channel model =
  Channel.init "app:main"
    |> Channel.on "new_msg" NewMsg
    |> Channel.onJoin NewMsg

subscriptions model =
  Phoenix.connect socket [channel model]