module Options exposing (..)

import Html exposing (Html, option, text)
import Html.Attributes exposing (value)
import Msg exposing (AppMsg)

stringToOption : String -> Html AppMsg
stringToOption s =
  option [ value s ] [ text s ]