import Html exposing (..)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (..)
import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push
import Json.Encode as JE
import Json.Decode as JDC exposing (Decoder)
import Navigation
import String
import List exposing (..)

main : Program Never Model Msg
main =
    Navigation.program UrlChange
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }



-- main : Program Never Model Msg
-- main =
--     Html.program
--         { init = init
--         , update = update
--         , subscriptions = subscriptions
--         , view = view 
--         }


type alias Model =
    { currentRoute : Navigation.Location
    }

type RoutePath
    = DefaultRoute
    | HomeRoute
    | LoginRoute
    | NotFoundRoute


init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    { currentRoute = location
    }
    ! []

-- type alias Model =
--   {
--     username : String,
--     password : String,
--     status : String
--   }

-- init : ( Model, Cmd Msg )
-- init =
--   ( initModel, Cmd.none )

-- initModel : Model
-- initModel = 
--   { username = "xxx" 
--   , password = "yyy"
--   , status = "Not initiated"
--   }

type Msg
    = UrlChange Navigation.Location

-- type Msg
--   =  NewMsg JDC.Value | Password String | SendMsg | Username String

-- mainSocket : String
-- mainSocket =
--   "ws://localhost:4000/socket/websocket?user=Otto&pwd=hemligt"


-- socket =
--   Socket.init mainSocket

-- channel model =
--   Channel.init "app:main"
--     |> Channel.on "new_msg" NewMsg
--     |> Channel.onJoin NewMsg

-- subscriptions model =
--   Phoenix.connect socket [channel model]

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UrlChange location ->
          { model | currentRoute = location } ! []

-- update : Msg -> Model -> ( Model, Cmd Msg )
-- update msg model =
--   case msg of
--     NewMsg payload -> 
--       { model | status = toString payload } ! []

--     Password password ->
--       { model | password = password } ! []

--     Username username -> 
--       { model | username = username } ! []

--     SendMsg -> 
--       let 
--         push = 
--           Push.init "app:main" "new_msg"
--             |> Push.withPayload (JE.object [( "msg",  JE.string model.password )])
--       in
--         { model | status = "sending" } ! [ Phoenix.push mainSocket push ]


-- Navigation


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
                homePage

            HomeRoute ->
                homePage

            LoginRoute ->
                loginPage

            NotFoundRoute ->
                notFoundPage


view : Model -> Html Msg
view model =
    div [ style [ ( "margin", "20px" ) ] ]
        [ pageBody model
    ]


-- view : Model -> Html Msg
-- view model =
--   div [class "mr-main flex-column flex-start"][
--     div [class "dialog-large"][
--       div [class "flex-end"][
--         button [class "input"][
--           text "Sign up"
--         ]
--       ],
--       input [class "input input-text", placeholder "username", type_ "text", onInput Username][

--       ],
--       input [class "input input-text", placeholder "password", type_ "text", onInput Password][

--       ], button [class "input", onClick SendMsg][
--         text "Sign in"
--       ],
--       div [][
--         text model.status
--       ]
--     ],
--     viewEmpty "Username" model.username,
--     viewEmpty "Password" model.password
--   ]

-- viewEmpty : String -> String -> Html Msg
-- viewEmpty parameterName parameter = 
--   if parameter == "" then
--     div [class "feedback error"][
--       text (parameterName ++ " empty")
--     ]
--   else div [][]

homePage : Html Msg
homePage =
    h1 [] [ text "Home" ]

loginPage : Html Msg
loginPage =
    h1 [] [ text "Login" ]

notFoundPage : Html Msg
notFoundPage =
    h1 [] [ text "Page not found" ]


-- Subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none