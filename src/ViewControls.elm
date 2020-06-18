module ViewControls exposing (..)

import Html exposing (Html)
import Element exposing (..)
import Element.Background as Background
import Element.Input as Input
import Element.Font as Font
import RoomInfo exposing (RoomInfo)


type alias Msg =
    RoomInfo.Msg


controls : RoomInfo -> Html Msg
controls { direction } =
    layout [] <| el
        [ 
          Font.size 18
        , Font.family
            [ Font.typeface "Open Sans"
            , Font.sansSerif
            ]
        , centerX
        ]
        ( selectDirection direction )


selectDirection : RoomInfo.Direction -> Element Msg
selectDirection s =
    Input.radioRow
        [ padding 10
    , spacing 20]
        { onChange = RoomInfo.ChangeDirection
        , selected = Just s
        , label = Input.labelAbove [] (text "")
        , options =
            [ Input.option RoomInfo.Vertical (text "Vertical")
            , Input.option RoomInfo.Horizontal (text "Horizontal")
            ]
        }
