module View exposing (view)

import Css exposing (..)
import Css.Media
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onClick)
import Html.Styled.Attributes
import Model exposing (..)

view : Model -> Html Msg
view model =
    styled div
        [ height (px ( toFloat model.windowSize.height) )
--        , backgroundColor (hex "a0a0a0")
        , displayFlex
        , alignItems center
        , justifyContent center
        ]
        []
        [ styled div
            [ width (pct 50)
            , height (pct 100)
--            , backgroundColor (hex "a0a0ff")
            , displayFlex
            , alignItems center
            , justifyContent center
            , flexDirection column
            , Css.Media.withMedia
                [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (px 1000) ] ]
                [ width (pct 100) ]
            ]
            []
            [ styled div
                [ width (pct 80)
--                , backgroundColor (hex "a0ffa0")
                , displayFlex
                , textAlign center
                , justifyContent center
                , alignItems center
                , fontSize (vh 12)
                , fontFamily monospace
                ]
                []
                [ if isWaiting model
                    then text (toString model.lastDirection)
                    else text (toString model.direction)
                ]
            , spacing
            , styled img
                [ width (pct 20) ]
                [ Html.Styled.Attributes.src
                    (
                        if isWaiting model
                        then (if model.correctGuess then "/assets/check.svg" else "/assets/minus.svg")
                        else "/assets/question-mark.svg"
                    )
                ]
                []
            , spacing
            , styled div
                [ width (pct 90)
                , height (pct 40)
--                , backgroundColor (hex "ffa0a0")
                , displayFlex
                , alignItems center
                , justifyContent spaceBetween
                , flexDirection row
                ]
                []
                [ styled button
                    [ width (pct 45)
                    , height (pct 100)
                    , fontSize (vh 12)
                    , borderStyle none
                    , borderRadius (px 20)
                    , boxShadow3 (px 7) (px 10) (hex "f0f0f0")
                    , borderColor (hex "a0a0f0")
                    , backgroundColor (hex "a0a0ff")
                    , color (rgba 255 255 255 0.6)
                    , disabled [ backgroundColor (rgba 160 160 240 0.5) ]
--                    , active [ backgroundColor (rgba 120 120 240 1.0) ]
                    ]
                    [ onClick (DirectionClicked Left)
                    , Html.Styled.Attributes.disabled (isWaiting model)
                    ]
                    [ text "←" ]
                , styled button
                    [ width (pct 45)
                    , height (pct 100)
                    , fontSize (vh 12)
                    , borderStyle none
                    , borderRadius (px 20)
                    , boxShadow3 (px 7) (px 10) (hex "f0f0f0")
                    , borderColor (hex "f0a0a0")
                    , backgroundColor (hex "ffa0a0")
                    , color (rgba 255 255 255 0.6)
                    , disabled [ backgroundColor (rgba 240 160 160 0.5) ]
--                    , active [ backgroundColor (rgba 240 120 120 1.0) ]
                    ]
                    [ onClick (DirectionClicked Right)
                    , Html.Styled.Attributes.disabled (isWaiting model)
                    ]
                    [ text "→" ]
                ]
            ]
        ]


spacing =
    styled div
        [ height (pct 5)
        ]
        []
        []


isWaiting : Model -> Bool
isWaiting model =
    model.time - model.directionClickedTime < 1
