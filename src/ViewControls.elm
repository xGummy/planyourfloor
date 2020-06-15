module ViewControls exposing (..)

import Element exposing (..)
import Element.Background as Background
import Element.Input as Input
import RoomInfo exposing (RoomInfo)


type alias Msg =
    RoomInfo.Msg


controls : RoomInfo -> Element Msg
controls { direction } =
    column
        [ height fill
        , width <| px 300
        , Background.color <| rgb255 240 240 240
        ]
        [ selectDirection direction ]


selectDirection : RoomInfo.Direction -> Element Msg
selectDirection s =
    Input.radioRow
        [ padding 10
        , spacing 20
        ]
        { onChange = RoomInfo.ChangeDirection
        , selected = Just s
        , label = Input.labelAbove [] (text "Direction")
        , options =
            [ Input.option RoomInfo.Vertical (text "Vertical")
            , Input.option RoomInfo.Horizontal (text "Horizontal")
            ]
        }
