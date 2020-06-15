module RoomInfo exposing (..)

import IntField exposing (IntField)


type Direction
    = Vertical
    | Horizontal


type alias RoomInfo =
    { roomLength : IntField
    , roomWidth : IntField
    , boardLength : IntField
    , boardWidth : IntField
    , direction : Direction
    }


type Msg
    = RoomLength String
    | RoomWidth String
    | BoardLength String
    | BoardWidth String
    | ChangeDirection Direction


init : RoomInfo
init =
    RoomInfo (IntField 0 "") (IntField 0 "") (IntField 0 "") (IntField 0 "") Vertical


updateRoomLength : IntField -> RoomInfo -> RoomInfo
updateRoomLength v model =
    { model | roomLength = v }


updateRoomWidth : IntField -> RoomInfo -> RoomInfo
updateRoomWidth v model =
    { model | roomWidth = v }


updateBoardLength : IntField -> RoomInfo -> RoomInfo
updateBoardLength v model =
    { model | boardLength = v }


updateBoardWidth : IntField -> RoomInfo -> RoomInfo
updateBoardWidth v model =
    { model | boardWidth = v }
