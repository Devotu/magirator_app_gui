module InputText exposing (..)

import Html exposing (Html, input)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Ms exposing (Msg)

inputText : String -> (String -> Msg) -> Html Msg
inputText ph msg =
    input [class "input input-text", placeholder ph, type_ "text", onInput msg][ ]