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
        , backgroundColor (hex "a0a0a0")
        , displayFlex
        , alignItems center
        , justifyContent center
        ]
        []
        [ styled div
            [ width (pct 50)
            , height (pct 100)
            , backgroundColor (hex "a0a0ff")
            , displayFlex
            , alignItems center
            , justifyContent spaceAround
            , flexDirection column
            , Css.Media.withMedia
                [ Css.Media.only Css.Media.screen [ Css.Media.maxWidth (px 1000) ] ]
                [ width (pct 100) ]
            ]
            []
            [ styled div
                [ width (pct 80)
                , backgroundColor (hex "a0ffa0")
                , displayFlex
                , textAlign center
                , justifyContent center
                , alignItems center
                , fontSize (vw 8)
                , fontFamily monospace
                ]
                []
                [ if isWaiting model
                    then text (if model.correctGuess then "✔" else "✘")
                    else text (toString model.direction)
                ]
            , styled div
                [ width (pct 80)
                , height (pct 40)
--                , backgroundColor (hex "ffa0a0")
                , displayFlex
                , alignItems center
                , justifyContent spaceBetween
                , flexDirection row
                ]
                []
                [ styled button
                    [ width (pct 40)
                    , height (pct 100)
                    , fontSize (vw 8)
--                    , backgroundColor (hex "ffffa0")
                    ]
                    [ onClick (DirectionClicked Left)
                    , Html.Styled.Attributes.disabled (isWaiting model)
                    ]
                    [ text "←" ]
                , styled button
                    [ width (pct 40)
                    , height (pct 100)
                    , fontSize (vw 8)
--                    , backgroundColor (hex "ffffa0")
                    ]
                    [ onClick (DirectionClicked Right)
                    , Html.Styled.Attributes.disabled (isWaiting model)
                    ]
                    [ text "→" ]
                ]
            ]
        ]


isWaiting : Model -> Bool
isWaiting model =
    model.time - model.directionClickedTime < 1
