module LoginView exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Msg exposing (..)
import Model exposing (Model)


page : Model -> Html AppMsg
page model =
  div [class "mr-main flex-column flex-start"][
    div [class "dialog-large"][
      div [class "flex-end"][
        button [class "input"][
          text "Sign up"
        ]
      ]
      , input [class "input input-text", placeholder "username", type_ "text", onInput Username][ ]
      , input [class "input input-text", placeholder "password", type_ "text", onInput Password][ ]
      , button [class "input", onClick ChannelAppJoin][
        text ("Sign in (" ++ model.username ++ "/" ++ model.password ++ ")")
      ]
    ],
    viewEmpty "Username" model.username
    ,viewEmpty "Password" model.password
  ]

viewEmpty : String -> String -> Html AppMsg
viewEmpty parameterName parameter = 
  if parameter == "" then
    div [class "feedback error"][
      text (parameterName ++ " empty")
    ]
  else div [][]