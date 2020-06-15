module ViewHeader exposing (header)

import Html exposing (Html)
import Html.Attributes exposing (src, alt, class)

header : Html msg
header =
    Html.div
        [ class "header"]
        [ headerText
        , headerImage
        ]


headerImage : Html msg
headerImage =
    Html.img
        [src "src/img/klusser.png", alt "cartoon of floor worker", class "header-image"][]


headerText : Html msg
headerText =
    Html.h1
        [class "header-text"]
        [Html.text "Plan your floor"]
