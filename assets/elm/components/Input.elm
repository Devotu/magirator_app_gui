module Input exposing (..)

import Html exposing (Html, input, div, select, text, label, legend, fieldset)
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

inputColors : (String -> Msg) -> Html Msg
inputColors msg = 
    fieldset [class "color-box"][
        inputCheckbox "black" msg
        ,inputCheckbox "white" msg
        ,inputCheckbox "red" msg
        ,inputCheckbox "green" msg
        ,inputCheckbox "blue" msg
        ,inputCheckbox "colorless" msg
      ]

inputCheckbox : String -> (String -> Msg) -> Html Msg
inputCheckbox color msg =
    div [class ("input-checkbox checkbox-" ++ color)][
        input [class "checkbox-hidden", type_ "checkbox", id ("id" ++ color), onInput msg][]
        ,label [class "checkbox-color-label", for ("id" ++ color) ][]
    ]