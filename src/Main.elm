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
    | Increment


update : Msg -> Model -> Model
update msg model =
    case msg of
        Decrement ->
            if model <= 0 then
                0

            else
                model - 1


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1
            []
            [ H.text "Hello, Friday Tech Lounge!" ]
        , H.button
            [ HE.onClick Decrement
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "-1" ]
        , H.div
            [ HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text <| String.fromInt model ]
        , H.button
            [ HE.onClick Increment
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
