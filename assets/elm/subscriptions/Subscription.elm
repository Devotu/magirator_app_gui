module Subscription exposing (..)

import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push

import ChannelStatus exposing (..)
import Model exposing (..)
import Ms exposing (..)

socket : Model -> Socket.Socket Msg
socket model =
  Socket.init model.socketUrl
    |> Socket.withParams[ ("user", model.username), ("pwd", model.password) ]
    |> Socket.onOpen SocketInitated
    |> Socket.onAbnormalClose SocketDenied


channel : Model -> Channel.Channel Msg
channel model =
  Channel.init "app:main"
    |> Channel.on "new_msg" NewMsg
    |> Channel.onJoin AppChannelInitiated


subscriptions : Model -> Sub Msg
subscriptions model =
  if model.channelStatus == ConnectionInitiated then 
    Phoenix.connect (socket model) [channel model]
  else 
    Sub.none
