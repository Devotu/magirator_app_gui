module Options exposing (..)

import Html exposing (Html, option, text)
import Html.Attributes exposing (value)
import Ms exposing (Msg)

stringToOption : String -> Html Msg
stringToOption s =
  option [ value s ] [ text s ]