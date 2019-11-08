module Contestant exposing
    ( State
    , config
    , init
    , setMaxHP
    , setMinHP
    , setName
    , view
    , viewMatchup
    )

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


type alias State =
    { hitPoints : Int
    , name : String
    , config : Config
    }


init : Config -> State
init c =
    { hitPoints = c.maxHP
    , name = c.name
    , config = c
    }


type alias Config =
    { maxHP : Int
    , minHP : Int
    , name : String
    }


config : Config
config =
    { maxHP = hitPointsInit
    , minHP = hitPointsEnd
    , name = "Some guy"
    }


setMaxHP : Int -> Config -> Config
setMaxHP hp c =
    { c | maxHP = hp }


setMinHP : Int -> Config -> Config
setMinHP hp c =
    { c | minHP = hp }


setName : String -> Config -> Config
setName n c =
    { c | name = n }


viewMatchup : State -> State -> H.Html msg
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


updateContestantName : State -> String -> State
updateContestantName state name =
    { state | name = name }


decrementHitPoints : State -> State
decrementHitPoints state =
    if state.hitPoints <= state.config.minHP then
        { state | hitPoints = state.config.minHP }

    else
        { state | hitPoints = state.hitPoints - 1 }


incrementHitPoints : State -> State
incrementHitPoints state =
    if state.hitPoints >= state.config.maxHP then
        { state | hitPoints = state.config.maxHP }

    else
        { state | hitPoints = state.hitPoints + 1 }


view : State -> (State -> msg) -> H.Html msg
view state updateMsg =
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
            , HA.disabled <| state.hitPoints == state.config.minHP
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
            , HA.disabled <| state.hitPoints == state.config.maxHP
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
