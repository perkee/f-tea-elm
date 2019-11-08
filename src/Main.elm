module Main exposing (main)

import Browser
import Css
import Html.Styled as H
import Html.Styled.Attributes as HA
import Html.Styled.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = 10
        , update = update
        , view = view >> H.toUnstyled
        }


type alias Model =
    Int


type Msg
    = Decrement


update : Msg -> Model -> Model
update msg model =
    case msg of
        Decrement ->
            model - 1


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1
            []
            [ H.text "Hello, Friday Tech Lounge!" ]
        , H.text <| String.fromInt model
        , H.button
            [ HE.onClick Decrement ]
            [ H.text "-1" ]
        ]
