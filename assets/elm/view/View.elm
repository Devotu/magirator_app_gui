module View exposing (..)

import Html exposing (Html, div, text, p)
import List exposing (..)
import Ms exposing (Msg)
import Model exposing (Model)

import Home exposing (homePage)
import Login exposing (loginPage)
import NewDeck exposing (newDeckPage)
import Error exposing (notFoundPage)
import DebugSquare exposing (debugSquare)
import NewNewDeck exposing (DeckMsg(..), Model, view)

type RoutePath
    = DefaultRoute
    | HomeRoute
    | LoginRoute
    | NewDeckRoute
    | NewDeckRoute2
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

            [ "newdeck2" ] ->
                NewDeckRoute2

            _ ->
              NotFoundRoute


pageBody : Model.Model -> Html Msg
pageBody model =
    let
        routePath =
            fromUrlHash model.currentRoute.hash
    in
        if 1 == 1 then
        -- if model.channelStatus == ConnectionStatus.Connected then
            case routePath of
                DefaultRoute ->
                    homePage model

                HomeRoute ->
                    homePage model

                LoginRoute ->
                    loginPage model

                NewDeckRoute ->
                    newDeckPage model

                NewDeckRoute2 ->
                    -- notFoundPage model
                    Html.map Ms.NewDeckMsg (NewNewDeck.view model.newDeck)

                NotFoundRoute ->
                    notFoundPage model
        
        else
            loginPage model



view : Model.Model -> Html Msg
view model =
    div [ ][  
            debugSquare model
            ,pageBody model
        ]
