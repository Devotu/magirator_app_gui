module Subscription exposing (..)

import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push

import Model exposing (..)
import Ms exposing (..)


mainSocketUrl : Model -> String
mainSocketUrl model =
  let 
    credentials = model.credentials
  in
    "ws://localhost:4000/socket/websocket?user=" ++ credentials.username ++ "&pwd=" ++ credentials.password

socket model =
  let 
    url = mainSocketUrl model
  in
    Socket.init url

channel model =
  Channel.init "app:main"
    |> Channel.on "new_msg" NewMsg
    |> Channel.onJoin NewMsg

subscriptions : Model -> Sub Msg
subscriptions model =
  let 
    credentials = model.credentials
  in
    if credentials.username /= "xxx" && credentials.password /= "yyy" then 
      Phoenix.connect (socket model) [channel model]
    else 
      Sub.none