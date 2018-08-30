module View exposing (..)

import Html exposing (Html, div, text, p)
import List exposing (..)

import Msg exposing (AppMsg)
import Model exposing (Model)
import ConnectionStatus

import DebugSquare exposing (debugSquare)

import HomeView
import LoginView
import NewDeckView
import DeckListView
import DeckView
import GameView
import AddGameView
import ErrorView

type RoutePath
    = DefaultRoute
    | HomeRoute
    | LoginRoute
    | NewDeckRoute
    | GameRoute String
    | DeckListRoute
    | DeckRoute String
    | DeckTabRoute String String
    | AddGameRoute String
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

            [ "game", id ] ->
                GameRoute id

            [ "decklist" ] ->
                DeckListRoute

            [ "deck", id, page ] ->
                DeckTabRoute id page

            [ "deck", id ] ->
                DeckRoute id

            [ "addgame", deckId ] ->
                AddGameRoute deckId
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
                    HomeView.page model

                HomeRoute ->
                    HomeView.page model

                LoginRoute ->
                    LoginView.page model

                NewDeckRoute ->
                    NewDeckView.page model.newDeck

                GameRoute gameId ->
                    case String.toInt gameId of
                        Ok id ->
                            GameView.page model id
                    
                        Err msg->
                            ErrorView.notFoundPage model
                            

                DeckListRoute ->
                    DeckListView.page model

                DeckTabRoute id page ->
                    case String.toInt id of
                        Ok deckId ->
                            DeckView.page deckId model page
                    
                        Err error ->
                            DeckView.page 0 model page

                DeckRoute id ->
                    case String.toInt id of
                        Ok deckId ->
                            DeckView.page deckId model "info"
                    
                        Err error ->
                            DeckView.page 0 model "info"

                AddGameRoute id ->
                    case String.toInt id of
                        Ok deckId ->
                            AddGameView.page model deckId
                    
                        Err error ->
                            AddGameView.page model 0
                            
                NotFoundRoute ->
                    ErrorView.notFoundPage model
        
        else
            LoginView.page model



view : Model.Model -> Html AppMsg
view model =
    div [ ][  
            debugSquare model
            ,pageBody model
        ]
