module Main exposing (main)

import Browser
import Html.Styled as H

main =
  H.h1
    []
    [ H.text "Hello, Friday Tech Lounge!" ]
  |> H.toUnstyled