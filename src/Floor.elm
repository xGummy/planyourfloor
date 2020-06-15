module Floor exposing (..)

import Boards exposing (Boards)
import RoomInfo exposing (RoomInfo)


type alias Floor =
    { floorPlan : FloorPlan
    , boards : Boards
    , labels : Labels
    , direction : RoomInfo.Direction
    }


init : Floor
init =
    Floor (FloorPlan 0 0 0 0 0 0) [] (Labels 0 0 0 0) RoomInfo.Vertical


fromRoomInfo : RoomInfo -> Floor
fromRoomInfo r =
    let
        floorPlan =
            initFloorPlan r 80

        labels =
            getLabels r 80

        boards =
            if allInputsComplete r then
                Boards.calculate r

            else
                []
    in
    Floor floorPlan boards labels r.direction


type alias FloorPlan =
    { absLength : Int
    , absWidth : Int
    , relLength : Float
    , relWidth : Float
    , offsetX : Float
    , offsetY : Float
    }


initFloorPlan : RoomInfo -> Float -> FloorPlan
initFloorPlan roomInfo default =
    let
        ( len, wid ) =
            ( roomInfo.roomLength.value, roomInfo.roomWidth.value )

        ( relLength, relWidth ) =
            if len > wid then
                ( default, getPercentage wid len default )

            else
                ( getPercentage len wid default, default )

        offSetX =
            50 - (relWidth / 2)

        offSetY =
            50 - (relLength / 2)
    in
    if inputsComplete roomInfo then
        FloorPlan len wid relLength relWidth offSetX offSetY

    else
        FloorPlan 0 0 0 0 0 0


type alias Labels =
    { absLength : Int
    , absWidth : Int
    , textLengthX : Float
    , textWidthY : Float
    }


getLabels : RoomInfo -> Float -> Labels
getLabels roomInfo default =
    let
        ( len, wid ) =
            ( roomInfo.roomLength.value, roomInfo.roomWidth.value )

        ( relLength, relWidth ) =
            if len > wid then
                ( default, getPercentage wid len default )

            else
                ( getPercentage len wid default, default )

        textLengthX =
            100 - (50 - (relLength / 2)) + 4

        textWidthY =
            100 - (50 - (relWidth / 2)) + 2
    in
    if inputsComplete roomInfo then
        Labels len wid textWidthY textLengthX

    else
        Labels 0 0 0 0


getPercentage : Int -> Int -> Float -> Float
getPercentage smaller larger default =
    if larger == 0 then
        0

    else
        (toFloat smaller / toFloat larger) * default


inputsComplete : RoomInfo -> Bool
inputsComplete { roomLength, roomWidth } =
    if roomLength.value /= 0 && roomWidth.value /= 0 then
        True

    else
        False


allInputsComplete : RoomInfo -> Bool
allInputsComplete { roomLength, roomWidth, boardLength, boardWidth } =
    if roomLength.value /= 0 && roomWidth.value /= 0 && boardLength.value /= 0 && boardWidth.value /= 0 then
        True

    else
        False
