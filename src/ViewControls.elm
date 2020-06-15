module ViewControls exposing (..)

import Html exposing (Html)
import Element exposing (..)
import Element.Background as Background
import Element.Input as Input
import RoomInfo exposing (RoomInfo)


type alias Msg =
    RoomInfo.Msg


controls : RoomInfo -> Html Msg
controls { direction } =
    layout [] <| el
        [ ]
        ( selectDirection direction )


selectDirection : RoomInfo.Direction -> Element Msg
selectDirection s =
    Input.radio
        []
        { onChange = RoomInfo.ChangeDirection
        , selected = Just s
        , label = Input.labelAbove [] (text "Direction")
        , options =
            [ Input.option RoomInfo.Vertical (text "Vertical")
            , Input.option RoomInfo.Horizontal (text "Horizontal")
            ]
        }
