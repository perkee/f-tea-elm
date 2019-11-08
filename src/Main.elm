module Main exposing (main)

import Browser
import Css
import Html.Styled as H
import Html.Styled.Attributes as HA
import Html.Styled.Events as HE


hitPointsInit : Int
hitPointsInit =
    10


hitPointsEnd : Int
hitPointsEnd =
    0


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view >> H.toUnstyled
        }


type alias Model =
    { firstContestant : ContestantState
    , otherContestant : ContestantState
    }


type alias ContestantState =
    { hitPoints : Int
    , name : String
    }


initContestantState : ContestantState
initContestantState =
    { hitPoints = hitPointsInit
    , name = "Some guy"
    }


init : Model
init =
    { firstContestant = initContestantState
    , otherContestant = initContestantState
    }


type Msg
    = UserUpdatedFirstContestant ContestantState
    | UserUpdatedOtherContestant ContestantState


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserUpdatedFirstContestant s ->
            { model | firstContestant = s }

        UserUpdatedOtherContestant s ->
            { model | otherContestant = s }


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1 [] [ H.text "Counting!" ]

        -- first guy
        , viewContestant
            model.firstContestant
            UserUpdatedFirstContestant

        -- Line!
        , H.hr [] []

        -- other guy
        , viewContestant
            model.otherContestant
            UserUpdatedOtherContestant

        -- Line!
        , H.hr [] []
        , viewMatchup
            model.firstContestant
            model.otherContestant
        ]


viewMatchup : ContestantState -> ContestantState -> H.Html msg
viewMatchup a b =
    (case compare a.hitPoints b.hitPoints of
        EQ ->
            a.name ++ " and " ++ b.name ++ " are tied."

        GT ->
            a.name ++ " is beating " ++ b.name ++ "."

        LT ->
            b.name ++ " is beating " ++ a.name ++ "."
    )
        |> H.text
        |> List.singleton
        |> H.div []


updateContestantName : ContestantState -> String -> ContestantState
updateContestantName state name =
    { state | name = name }


decrementHitPoints : ContestantState -> ContestantState
decrementHitPoints state =
    if state.hitPoints <= hitPointsEnd then
        { state | hitPoints = hitPointsEnd }

    else
        { state | hitPoints = state.hitPoints - 1 }


incrementHitPoints : ContestantState -> ContestantState
incrementHitPoints state =
    if state.hitPoints >= hitPointsInit then
        { state | hitPoints = hitPointsInit }

    else
        { state | hitPoints = state.hitPoints + 1 }


viewContestant : ContestantState -> (ContestantState -> msg) -> H.Html msg
viewContestant state updateMsg =
    H.div []
        [ -- Title
          H.input
            [ HA.type_ "text"
            , HA.value state.name
            , HE.onInput (updateContestantName state >> updateMsg)
            , HA.css
                [ Css.fontSize <|
                    Css.em 2
                , Css.display
                    Css.block
                ]
            ]
            []

        -- Decrement Button
        , H.button
            [ HE.onClick (decrementHitPoints state |> updateMsg)
            , HA.disabled <| state.hitPoints == hitPointsEnd
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "-1" ]

        -- Display
        , H.div
            [ HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text <| String.fromInt state.hitPoints ]

        -- Increment Button
        , H.button
            [ incrementHitPoints state
                |> updateMsg
                |> HE.onClick
            , HA.disabled <| state.hitPoints == hitPointsInit
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
