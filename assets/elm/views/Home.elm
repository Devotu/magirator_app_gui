module Home exposing (..)

import Html exposing (..)
import Ms exposing (..)
import Model exposing (Model)

homePage : Model -> Html Ms.Msg
homePage model =
    h1 [] [ text (model.username ++ " " ++ model.password) ]