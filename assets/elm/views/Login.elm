module Login exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Ms exposing (..)
import Model exposing (Model)


loginPage : Model -> Html Msg
loginPage model =
  div [class "mr-main flex-column flex-start"][
    div [class "dialog-large"][
      div [class "flex-end"][
        button [class "input"][
          text "Sign up"
        ]
      ],
      input [class "input input-text", placeholder "username", type_ "text", onInput Username][

      ],
      input [class "input input-text", placeholder "password", type_ "text", onInput Password][

      ], button [class "input", onClick ChannelMainConnect][
        text ("Sign in (" ++ model.username ++ "/" ++ model.password ++ ")")
      ],
      div [][
        p [][ text ("Status: " ++ model.status) ]
        , p [][ text ("Socket: " ++ toString model.socketStatus) ]
        , p [][ text ("Channel: " ++ toString model.channelStatus) ]
      ], button [class "input", onClick SendMsg][
        text "Send"
      ]
    ],
    viewEmpty "Username" model.username,
    viewEmpty "Password" model.password
  ]

viewEmpty : String -> String -> Html Msg
viewEmpty parameterName parameter = 
  if parameter == "" then
    div [class "feedback error"][
      text (parameterName ++ " empty")
    ]
  else div [][]