module ViewInputs exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Html exposing (Html)
import RoomInfo exposing (RoomInfo)


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


info : RoomInfo -> Element Msg
info roomInfo =
    wrappedRow
        [ width fill
        , padding 80
        , spacing 30
        ]
        [ floorPlan roomInfo Floor "src/img/floor.png"
        , floorPlan roomInfo Planks "src/img/planks.png"
        ]


floorPlan : RoomInfo -> Input -> String -> Element Msg
floorPlan roomInfo title img =
    column
        [ width <| fillPortion 1
        , height fill
        ]
        [ row [ height fill, spacing 20 ] [ floorImage title img, floorInputs roomInfo title ]
        ]


floorImage : Input -> String -> Element msg
floorImage title img =
    column
        [ width <| fillPortion 1 ]
        [ image [ width (fill |> minimum 150), centerY ] { src = img, description = "image of " ++ inputToString title }
        ]


type alias Msg =
    RoomInfo.Msg


type alias InputInfo =
    { lengthText : String
    , widthText : String
    , lengthMsg : String -> Msg
    , widthMsg : String -> Msg
    }


floorInputs : RoomInfo -> Input -> Element Msg
floorInputs roomInfo title =
    let
        inputInfo =
            case title of
                Floor ->
                    InputInfo roomInfo.roomLength.raw roomInfo.roomWidth.raw RoomInfo.RoomLength RoomInfo.RoomWidth

                Planks ->
                    InputInfo roomInfo.boardLength.raw roomInfo.boardWidth.raw RoomInfo.BoardLength RoomInfo.BoardWidth
    in
    column
        [ width <| fillPortion 1, spacing 20 ]
        [ row [ height <| fillPortion 1, width fill, padding 20 ]
            [ el [ centerX, Font.size 40 ] (text (inputToString title)) ]
        , row [ height <| fillPortion 1 ] [ viewInput inputInfo.lengthText "height " inputInfo.lengthMsg ]
        , row [ height <| fillPortion 1 ] [ viewInput inputInfo.widthText "width  " inputInfo.widthMsg ]
        ]


viewInput : String -> String -> (String -> Msg) -> Element Msg
viewInput t title msg =
    Input.text []
        { onChange = msg
        , text = t
        , placeholder = Nothing
        , label = Input.labelLeft [ centerY ] (text title)
        }
