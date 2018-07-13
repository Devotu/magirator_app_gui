module Subscription exposing (..)

import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel

import ConnectionStatus exposing (..)
import Model exposing (..)
import Ms exposing (..)

socket : Model -> Socket.Socket Msg
socket model =
  Socket.init model.socketUrl
    |> Socket.withParams[ ("user", model.username), ("pwd", model.password) ]
    |> Socket.onOpen SocketConnected
    |> Socket.onAbnormalClose SocketDenied

appChannel : Model -> String
appChannel model =
  "app:" ++ model.username

channel : Model -> Channel.Channel Msg
channel model =
  Channel.init (appChannel model)
    |> Channel.on "new_msg" NewMsg
    |> Channel.onJoin ChannelAppJoined
    |> Channel.onJoinError ChannelAppJoinError


subscriptions : Model -> Sub Msg
subscriptions model =
  if
    model.channelStatus == Connecting || model.channelStatus == Connected 
  then 
      Phoenix.connect (socket model) [channel model]
  else 
    Sub.none
