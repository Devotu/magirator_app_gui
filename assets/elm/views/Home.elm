module Home exposing (..)

import Html exposing (..)
import Msgs exposing (Msg)

homePage : Html Msg
homePage =
    h1 [] [ text "Home" ]