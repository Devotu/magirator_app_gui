module View exposing (..)

import Html exposing (Html, div)
import List exposing (..)
import Ms exposing (Msg)
import Model exposing (Model)

import Home exposing (homePage)
import Login exposing (loginPage)
import NewDeck exposing (newDeckPage)
import Error exposing (notFoundPage)

type RoutePath
    = DefaultRoute
    | HomeRoute
    | LoginRoute
    | NewDeckRoute
    | NotFoundRoute


fromUrlHash : String -> RoutePath
fromUrlHash urlHash =
    let
        hashList =
            urlHash |> String.split "/" |> drop 1
    in
        case hashList of
            [] ->
                DefaultRoute

            [ "home" ] ->
                HomeRoute

            [ "login" ] ->
                LoginRoute

            [ "newdeck" ] ->
                NewDeckRoute

            _ ->
              NotFoundRoute


pageBody : Model -> Html Msg
pageBody model =
    let
        routePath =
            fromUrlHash model.currentRoute.hash
    in
        case routePath of
            DefaultRoute ->
                homePage model

            HomeRoute ->
                homePage model

            LoginRoute ->
                loginPage model

            NewDeckRoute ->
                newDeckPage model

            NotFoundRoute ->
                notFoundPage model


view : Model -> Html Msg
view model =
    div [ ][ pageBody model ]