module Main exposing (main)

import Browser
import Html.Styled as H


main : Program () Model msg
main =
    Browser.sandbox
        { init = "Hello, Friday Tech Lounge!"
        , update = update
        , view = view >> H.toUnstyled
        }


type alias Model =
    String


update : msg -> Model -> Model
update _ model =
    model


view : Model -> H.Html msg
view model =
    H.h1
        []
        [ H.text model ]
