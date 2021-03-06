module View exposing (view)

import Constants exposing (waitingTime)
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
        [ width (px ( toFloat model.windowSize.width) )
        , height (px ( toFloat model.windowSize.height) )
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
            , justifyContent spaceBetween
            ]
            []
            [ styled img
                [ height (pt 45)
                , width (pt 45)
                , alignSelf center
                , marginLeft (pt 20)
                ]
                [ Html.Styled.Attributes.src
                    ( if model.muted
                        then "/assets/muted.svg"
                        else "/assets/unmuted.svg"
                    )
                , onClick (MutedClicked (not model.muted))
                ]
                []
            , styled div
                [ height (pt 80)
                , displayFlex
                , flexDirection row
                , alignItems center
                , alignSelf center
                , justifyContent center]
                []
                ( allLanguages
                    |> List.map
                        ( \language -> styled img
                            [ height (if model.language == language then pt 60 else pt 45)
                            , width (if model.language == language then pt 80 else pt 60)
                            , marginRight (pt 20)
                            , borderRadius (pt 10)
                            ]
                            [ Html.Styled.Attributes.src (getFlagPath language)
                            , onClick (LanguageClicked language)
                            ]
                            []
                        )
                )
            ]
        , styled div
            [ width (pct 50)
            , height (pct 100)
            , displayFlex
            , alignItems center
            , justifyContent center
            , flexDirection column
            , overflowX hidden
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
                , opacity (num <| getOpacity model)
                , marginLeft (pct <| getMarginLeft model)
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
                , onClick
                    ( PlaySoundClicked
                        { filepath = getDirectionSoundPath model.language model.direction
                        , timeout = 0
                        }
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
                    , backgroundColor (hex "ffb0a0")
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


spacing : Html msg
spacing =
    styled div
        [ height (pct 5) ]
        []
        []


isWaiting : Model -> Bool
isWaiting model =
    model.time - model.directionClickedTime < waitingTime


getOpacity : Model -> Float
getOpacity model =
    getT model |> sin


getT : Model -> Float
getT model =
    let
        dt =
            model.time - model.directionClickedTime
    in
        if dt < waitingTime
        then
            (waitingTime - dt) / waitingTime
        else if dt < waitingTime * 1.5
        then
            (dt - waitingTime) * 2 / waitingTime
        else
            1

getMarginLeft : Model -> Float
getMarginLeft model =
    let
        dt =
            model.time - model.directionClickedTime
        t =
            if dt < waitingTime
            then
                (waitingTime - dt) / waitingTime
            else
                1

        margin =
            sin ((1 - t) * pi / 2) * 150

        modifier =
            case model.lastDirection of
                Left -> -1
                Right -> 1
    in
        margin * modifier
