module IntField exposing (..)


type alias IntField =
    { value : Int, raw : String }


toIntField : String -> Maybe IntField
toIntField r =
    case maxLength r of
        False ->
            Nothing

        True ->
            case String.toFloat r of
                Just value ->
                    Just (IntField (round (value * 1000)) r)

                Nothing ->
                    case String.toFloat (r ++ "0") of
                        Just a ->
                            Just (IntField (round (a * 1000)) r)

                        Nothing ->
                            Nothing


maxLength : String -> Bool
maxLength raw =
    case String.split "." raw of
        [ number, decimal ] ->
            if String.length decimal < 3 then
                True

            else
                False

        _ ->
            True
