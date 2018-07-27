module Translation exposing (..)

import Model exposing (..)


translateDirection language direction =
    case language of
        English ->
            case direction of
                Left ->
                    "Left"
                Right ->
                    "Right"
        Swedish ->
            case direction of
                Left ->
                    "Vänster"
                Right ->
                    "Höger"
        French ->
            case direction of
                Left ->
                    "Gauche"
                Right ->
                    "Droite"
        Spanish ->
            case direction of
                Left ->
                    "Izquierda"
                Right ->
                    "Derecha"


getFlagPath language =
    case language of
        English ->
            "/assets/flags/gb.svg"
        Swedish ->
            "/assets/flags/se.svg"
        French ->
            "/assets/flags/fr.svg"
        Spanish ->
            "/assets/flags/es.svg"


allLanguages =
    [ French
    , Swedish
    , English
    , Spanish
    ]
