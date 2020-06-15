module ViewHeader exposing (header)

import Html exposing (Html)
import Html.Attributes exposing (src, alt, class)

header : Html msg
header =
    Html.div [ class "header-container" ] 
        [ Html.div
            [ class "header"]
            [ headerText ]
        , Html.div [ class "header-image-box"] 
                [ headerImage ]
        ]

headerImage : Html msg
headerImage =
    Html.img
        [src "src/img/emski-work.png", alt "cartoon of floor worker", class "header-image"][]


headerText : Html msg
headerText =
    Html.h1
        [class "header-text"]
        [Html.text "Plan your floor"]
