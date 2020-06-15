module Boards exposing (..)

import RoomInfo exposing (RoomInfo)


type Board
    = Board Int Int


type alias Row = List Board


type alias Boards =
    List Row


type alias Acc =
    { boards : Boards
    , rest : Int
    , roomLength : Int
    , boardLength : Int
    }


calculate : RoomInfo -> Boards
calculate r =
    let
        ( len, wid ) =
            case r.direction of
                RoomInfo.Vertical ->
                    ( r.roomLength.value, r.roomWidth.value )

                RoomInfo.Horizontal ->
                    ( r.roomWidth.value, r.roomLength.value )

        columns =
            wid // r.boardWidth.value

        restWidth =
            modBy r.boardWidth.value wid

        initFloor =
            if restWidth /= 0 then
                List.repeat columns r.boardWidth.value ++ [ restWidth ]

            else
                List.repeat columns r.boardWidth.value

        initAcc =
            Acc [] 0 len r.boardLength.value
    in
    List.reverse (List.foldl calculateRow initAcc initFloor).boards


calculateRow : Int -> Acc -> Acc
calculateRow width { boards, rest, roomLength, boardLength } =
    let
        fullBoards =
            (roomLength - rest) // boardLength

        restLength =
            if rest < roomLength then
                modBy boardLength (roomLength - rest)

            else
                roomLength

        restColumn =
            if restLength /= 0 then
                boardLength - restLength

            else
                0

        newBoards =
            if rest < roomLength then
                (Board rest width :: List.repeat fullBoards (Board boardLength width)) ++ [ Board restLength width ]

            else
                [ Board restLength width ]
    in
    Acc (newBoards :: boards) restColumn roomLength boardLength


currentWidth : Boards -> Int
currentWidth boards =
    let
        column =
            Maybe.withDefault [] <| List.head boards

        (Board _ wid) =
            Maybe.withDefault (Board 0 0) <| List.head column
    in
    wid


getLenWid : Board -> ( Int, Int )
getLenWid (Board len wid) =
    ( len, wid )
