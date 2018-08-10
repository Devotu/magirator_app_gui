module Input exposing (..)

import Html exposing (Html, input, select)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Ms exposing (Msg)
import Options exposing (stringToOption)

inputText : String -> (String -> Msg) -> Html Msg
inputText ph msg =
    input [class "input input-text", placeholder ph, type_ "text", onInput msg][ ]

inputSelect : List String -> (String -> Msg) -> Html Msg
inputSelect list msg =
    select [ onInput msg ] (List.map stringToOption list)