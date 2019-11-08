module View exposing
    ( container
    , header
    , keyValue
    , navIn
    , navOut
    , notFound
    )

import Css exposing (..)
import Html.Styled exposing (..)
import Html.Styled.Attributes as HSA

theme : { headerHeight : Rem }
theme =
    { headerHeight = rem 4 }



-- HEADER


header : List (Html msg) -> Html msg
header items =
    div
        [ HSA.class "fixed top-0 inset-x-0 bg-white border-b border-gray-300" -- Tailwind utilities: https://tailwindcss.com
        , HSA.css [ height theme.headerHeight ] -- elm-css: https://package.elm-lang.org/packages/rtfeldman/elm-css/latest
        ]
        [ div
            [ HSA.class "container mx-auto h-full"
            , HSA.class "flex items-center px-6"
            ]
            [ a
                [ HSA.attribute "data-test" "logo"
                , HSA.class "flex items-center"
                , HSA.href "/"
                ]
                [ div
                    [ HSA.class "bg-indigo-600 w-4 h-4 rounded-full mr-2" ]
                    []
                , p
                    [ HSA.class "font-bold uppercase text-sm text-gray-800" ]
                    [ text "Hello" ]
                ]
            , ul
                [ HSA.attribute "data-test" "menu"
                , HSA.class "flex-grow"
                , HSA.class "flex justify-end"
                ]
                items
            ]
        ]


item : String -> List (Attribute msg) -> Html msg
item name attributes =
    li [ HSA.class "mr-6" ] [ a attributes [ text name ] ]


navIn : String -> String -> Html msg
navIn name url =
    item name [ HSA.href url ]


navOut : String -> String -> Html msg
navOut name url =
    item name [ HSA.href url, HSA.target "_blank", HSA.class "external" ]



-- CONTAINER


container : List (Html msg) -> Html msg
container content =
    div
        [ HSA.attribute "data-test" "content"
        , HSA.class "container mx-auto py-10 px-4"
        , HSA.css [ marginTop theme.headerHeight ]
        ]
        content



-- DEFAULT PAGES


notFound : List (Html msg)
notFound =
    [ h1
        []
        [ div [ HSA.class "text-2xl text-gray-500" ] [ text "404" ]
        , text "Sorry, we could not find this page."
        ]
    , p
        []
        [ a
            [ HSA.class "btn", HSA.href "/" ]
            [ text "Home" ]
        ]
    ]



-- MISC


keyValue : String -> String -> List (Html msg)
keyValue key value =
    [ span
        [ HSA.class "inline-block mr-6 w-12"
        , HSA.class "text-gray-600 text-right text-xs uppercase"
        ]
        [ text key ]
    , span
        [ HSA.attribute "data-value" key ]
        [ text value ]
    ]
