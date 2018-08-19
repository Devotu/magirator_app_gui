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
import DeckList
import DeckMain

type RoutePath
    = DefaultRoute
    | HomeRoute
    | LoginRoute
    | NewDeckRoute
    | DeckListRoute
    | DeckRoute String
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

            [ "decklist" ] ->
                DeckListRoute

            [ "deck", id ] ->
                DeckRoute id

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

                DeckListRoute ->
                    DeckList.page model

                DeckRoute id ->
                    case String.toInt id of
                        Ok deckId ->
                            DeckMain.page deckId model
                    
                        Err error ->
                                DeckMain.page 0 model
                            
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
