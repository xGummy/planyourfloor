module ViewInputs exposing (..)

import Html exposing (Html)
import Html.Attributes exposing (..)
import RoomInfo exposing (RoomInfo)
import Html.Events exposing (onInput)


type Input
    = Floor
    | Planks


inputToString : Input -> String
inputToString input =
    case input of
        Floor ->
            "floor"

        Planks ->
            "planks"


info : RoomInfo -> Html Msg
info roomInfo =
    Html.div
        [ class "inputs-container"]
        [ floorPlan roomInfo Floor "src/img/floor.png"
        , floorPlan roomInfo Planks "src/img/planks.png"
        ]


floorPlan : RoomInfo -> Input -> String -> Html Msg
floorPlan roomInfo title img =
    Html.div [class "input-floorplan"]
        [ floorImage title img, floorInputs roomInfo title ]


floorImage : Input -> String -> Html Msg
floorImage title img =
    Html.div
        [ class "input-image" ]
        [ Html.img [src img, alt <| inputToString title][]]


type alias Msg =
    RoomInfo.Msg


type alias InputInfo =
    { lengthText : String
    , widthText : String
    , lengthMsg : String -> Msg
    , widthMsg : String -> Msg
    }


floorInputs : RoomInfo -> Input -> Html Msg
floorInputs roomInfo title =
    let
        inputInfo =
            case title of
                Floor ->
                    InputInfo roomInfo.roomLength.raw roomInfo.roomWidth.raw RoomInfo.RoomLength RoomInfo.RoomWidth

                Planks ->
                    InputInfo roomInfo.boardLength.raw roomInfo.boardWidth.raw RoomInfo.BoardLength RoomInfo.BoardWidth
    in
    Html.div
        [ class "inputs" ]
        [ Html.h2 [class "input-title"] [Html.text (inputToString title)]
        , Html.input [ value inputInfo.lengthText, placeholder "height ", onInput inputInfo.lengthMsg ] []
        , Html.input [ value inputInfo.widthText, placeholder "width ", onInput inputInfo.widthMsg ] []
        ]
