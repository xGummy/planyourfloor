module Main exposing (..)

import Browser
import Floor exposing (Floor)
import Html exposing (Html)
import Html.Attributes exposing (class, src, alt)
import IntField exposing (IntField)
import RoomInfo exposing (RoomInfo)
import ViewFloor
import ViewHeader
import ViewInputs
import ViewControls


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }



-- MODEL


type alias Model =
    { roomInfo : RoomInfo
    , floor : Floor
    }


init : () -> ( Model, Cmd Msg )
init _ =
    ( Model RoomInfo.init Floor.init
    , Cmd.none
    )



-- UPDATE


type alias Msg =
    RoomInfo.Msg


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RoomInfo.RoomLength l ->
            updateDimension l model RoomInfo.updateRoomLength

        RoomInfo.RoomWidth w ->
            updateDimension w model RoomInfo.updateRoomWidth

        RoomInfo.BoardLength l ->
            updateDimension l model RoomInfo.updateBoardLength

        RoomInfo.BoardWidth w ->
            updateDimension w model RoomInfo.updateBoardWidth

        RoomInfo.ChangeDirection v ->
            let
                roomInfo =
                    model.roomInfo

                updatedModel =
                    { model | roomInfo = { roomInfo | direction = v } }
            in
            ( { updatedModel | floor = Floor.fromRoomInfo updatedModel.roomInfo }, Cmd.none )


updateDimension : String -> Model -> (IntField -> RoomInfo -> RoomInfo) -> ( Model, Cmd Msg )
updateDimension value model updateFun =
    let
        updatedModel =
            case IntField.toIntField value of
                Just v ->
                    { model | roomInfo = updateFun v model.roomInfo }

                Nothing ->
                    model
    in
    ( { updatedModel | floor = Floor.fromRoomInfo updatedModel.roomInfo }
    , Cmd.none
    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> Html Msg
view model =
            Html.div [class "page-container"][
              ViewHeader.header
              , Html.div [class "main-content"]
              [
               Html.div [class "side-panel"] [
                ViewInputs.info model.roomInfo
        , ViewControls.controls model.roomInfo
              ]
            , ViewFloor.floor model.floor model.roomInfo
              ]
            ]
