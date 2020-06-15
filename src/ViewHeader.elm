module ViewHeader exposing (header)

import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input


header : Element msg
header =
    row
        [ width fill
        , height <| px 390
        , Background.color <| rgb255 247 216 171
        , Font.family
            [ Font.external
                { name = "Raleway"
                , url = "https://fonts.googleapis.com/css?family=Raleway"
                }
            , Font.sansSerif
            ]
        ]
        [ headerText
        , headerImage
        ]


headerImage : Element msg
headerImage =
    image
        [ height <| px 500
        , centerX
        ]
        { src = "src/img/klusser.png", description = "cartoon of floor worker" }


headerText : Element msg
headerText =
    el
        [ Font.size 90
        , padding 60
        , centerX
        ]
        (text "Plan your floor")
