import Html exposing (..)
import Phoenix
import Phoenix.Socket as Socket
import Phoenix.Channel as Channel
import Phoenix.Push as Push
import Json.Encode as JE
import Navigation
import String

import Model exposing (Model)
import Ms exposing (Msg)
import Subscription exposing (subscriptions)
import Update exposing (update)
import View exposing (view)

main : Program Never Model Msg
main =
    Navigation.program Ms.UrlChange
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }




-- Remains 
init : Navigation.Location -> ( Model, Cmd Msg )
init location =
    { currentRoute = location
    , credentials = { username = "xxx", password = "yyy" }
    , status = "Not initiated"
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
