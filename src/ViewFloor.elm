module ViewFloor exposing (..)

import Boards exposing (Board, Boards)
import Css as C
import Element exposing (..)
import Element.Background as Background
import Floor exposing (Floor)
import Html.Styled exposing (Html)
import RoomInfo exposing (RoomInfo)
import Svg.Styled as Svg
import Svg.Styled.Attributes as S
import ViewControls


type alias Msg =
    RoomInfo.Msg


floor : Floor -> RoomInfo -> Element Msg
floor f roomInfo =
    row
        [ width fill
        , height <| px 900
        ]
        [ ViewControls.controls roomInfo
        , viewSvg f
        ]


viewSvg : Floor -> Element Msg
viewSvg f =
    column
        [ width <| px 900
        , height fill
        , centerX
        , centerY
        ]
        [ html <| Svg.toUnstyled (drawFloor f) ]


drawFloor : Floor -> Html Msg
drawFloor f =
    Svg.svg
        [ S.width "900px"
        , S.height "900px"
        , S.viewBox "0 0 900 900"
        , S.class "m-3 border border-dark"
        ]
    <|
        [ Svg.g [ S.transform <| getTransForm f.direction f.floorPlan ]
            (drawBoards f)
        ]
            ++ [ drawRoom f.floorPlan ]
            ++ drawLabels f.labels


drawRoom : Floor.FloorPlan -> Svg.Svg msg
drawRoom f =
    Svg.rect
        [ S.x <| toPercentString f.offsetX
        , S.y <| toPercentString f.offsetY
        , S.width <| toPercentString f.relWidth
        , S.height <| toPercentString f.relLength
        , S.strokeWidth "3"
        , S.fill "none"
        , S.stroke "black"
        ]
        []


drawLabels : Floor.Labels -> List (Svg.Svg msg)
drawLabels f =
    [ Svg.text_
        [ S.x "50%"
        , S.y <| toPercentString f.textWidthY
        , S.textAnchor "middle"
        , S.fontFamily "sans-serif"
        ]
        [ Svg.text <| displayRaw f.absWidth ]
    , Svg.text_
        [ S.x <| toPercentString f.textLengthX
        , S.y "50%"
        , S.textAnchor "left"
        , S.fontFamily "sans-serif"
        ]
        [ Svg.text <| displayRaw f.absLength ]
    ]


toPercentString : Float -> String
toPercentString value =
    String.fromFloat value ++ "%"


displayRaw : Int -> String
displayRaw v =
    if v /= 0 then
        String.fromFloat <| toFloat v / 1000

    else
        ""


type alias DrawAcc =
    { boards : List (Svg.Svg Msg)
    , offsetX : Float
    , offsetY : Float
    , relFactor : Float
    , stdOffsetY : Float
    , stdWid : Int
    }


drawBoards : Floor -> List (Svg.Svg Msg)
drawBoards f =
    let
        wid =
            Boards.currentWidth f.boards

        relFactor =
            f.floorPlan.relLength / toFloat f.floorPlan.absLength

        startOffsetX =
            f.floorPlan.offsetX - (relFactor * toFloat wid)

        startOffsetY =
            f.floorPlan.offsetY - (relFactor * toFloat wid)

        initAcc =
            case f.direction of
                RoomInfo.Vertical ->
                    DrawAcc [] startOffsetX f.floorPlan.offsetY relFactor f.floorPlan.offsetY wid

                RoomInfo.Horizontal ->
                    DrawAcc [] startOffsetY f.floorPlan.offsetX relFactor f.floorPlan.offsetX wid
    in
    (List.foldl drawColumn initAcc f.boards).boards


drawColumn : List Board -> DrawAcc -> DrawAcc
drawColumn boards acc =
    let
        newOffsetX =
            acc.offsetX + (acc.relFactor * toFloat acc.stdWid)

        newAcc =
            { acc | offsetX = newOffsetX, offsetY = acc.stdOffsetY }
    in
    List.foldl drawBoard newAcc boards


drawBoard : Board -> DrawAcc -> DrawAcc
drawBoard board acc =
    let
        ( len, wid ) =
            Boards.getLenWid board

        titleString =
            displayRaw len ++ " x " ++ displayRaw wid

        newOffsetY =
            acc.offsetY + (acc.relFactor * toFloat len)

        newBoard =
            Svg.rect
                [ S.x <| toPercentString acc.offsetX
                , S.y <| toPercentString acc.offsetY
                , S.width <| toPercentString (acc.relFactor * toFloat wid)
                , S.height <| toPercentString (acc.relFactor * toFloat len)
                , S.strokeWidth "1"
                , S.stroke "black"
                , S.fill "#c48d58"
                , S.css [ C.hover [ C.fill <| C.hex "bf864e " ] ]
                , S.class "data-tooltip"
                ]
                [ Svg.title [] [ Svg.text titleString ] ]
    in
    { acc | offsetY = newOffsetY, boards = newBoard :: acc.boards }


getTransForm : RoomInfo.Direction -> Floor.FloorPlan -> String
getTransForm direction floorPlan =
    case direction of
        RoomInfo.Vertical ->
            ""

        RoomInfo.Horizontal ->
            "rotate(90 450 450)"
