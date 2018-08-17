module View exposing (..)

import Html exposing (Html, div, text, p)
import List exposing (..)
import Msg exposing (AppMsg)
import Model exposing (Model)


import Home exposing (homePage)
import Login exposing (loginPage)
import Error exposing (notFoundPage)

import DebugSquare exposing (debugSquare)

import ConnectionStatus
import NewDeck

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


pageBody : Model.Model -> Html AppMsg
pageBody model =
    let
        routePath =
            fromUrlHash model.currentRoute.hash
    in
        if model.channelStatus == ConnectionStatus.Connected then
            case routePath of
                DefaultRoute ->
                    homePage model

                HomeRoute ->
                    homePage model

                LoginRoute ->
                    loginPage model

                NewDeckRoute ->
                    NewDeck.view model.newDeck

                NotFoundRoute ->
                    notFoundPage model
        
        else
            loginPage model



view : Model.Model -> Html AppMsg
view model =
    div [ ][  
            debugSquare model
            ,pageBody model
        ]
