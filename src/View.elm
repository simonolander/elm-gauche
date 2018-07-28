module View exposing (view)

import Css exposing (..)
import Css.Media
import Html.Styled exposing (..)
import Html.Styled.Events exposing (onClick)
import Html.Styled.Attributes
import Model exposing (..)
import Translation exposing (..)

view : Model -> Html Msg
view model =
    styled div
        [ height (px ( toFloat model.windowSize.height) )
        , displayFlex
        , alignItems center
        , justifyContent center
        , flexDirection column
        ]
        []
        [ styled div
            [ width (pct 100)
            , height (pt 80)
            , displayFlex
            , flexDirection row
            , alignItems center
            , marginLeft auto
            , justifyContent center
            ]
            []
            ( allLanguages
                |> List.map
                    (\language -> styled img
                        [ height (if model.language == language then pt 60 else pt 45)
                        , width (if model.language == language then pt 80 else pt 60)
                        , marginRight (pt 20)
                        , borderRadius (pt 10)
                        , lastChild
                            [ marginRight (px 0)]
                        ]
                        [ Html.Styled.Attributes.src (getFlagPath language)
                        , onClick (LanguageClicked language)]
                        []
                    )
            )
        , styled div
            [ width (pct 50)
            , height (pct 100)
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
                , displayFlex
                , textAlign center
                , justifyContent center
                , alignItems center
                , fontSize (vh 10)
                , fontFamily monospace
                ]
                []
                [ if isWaiting model
                    then (text << translateDirection model.language) model.lastDirection
                    else (text << translateDirection model.language) model.direction
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
                    ]
                    [ onClick (DirectionClicked Right)
                    , Html.Styled.Attributes.disabled (isWaiting model)
                    ]
                    [ text "→" ]
                ]
            ]
        , styled div
            [ position absolute
            , right (px 20)
            , bottom (px 20)
            , fontFamily monospace
            , textAlign right
            , color (rgba 0 0 0 0.75)
            ]
            []
            [ styled span
                [ display block ]
                []
                [text "@ Simon Olander Sahlén"]
            , styled span
                [ display block ]
                []
                [text "@ Anita Chainiau"]
            , a
                [ Html.Styled.Attributes.href "https://github.com/simonolander/elm-gauche" ]
                [ text "Source code" ]
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
