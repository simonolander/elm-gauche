module Translation exposing (..)

import Model exposing (..)


translateDirection : Language -> Direction -> String
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


getFlagPath : Language -> String
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


getDirectionSoundPath : Language -> Direction -> String
getDirectionSoundPath language direction =
    case language of
        English ->
            case direction of
                Left ->
                    "/assets/sound/en_left_01.m4a"
                Right ->
                    "/assets/sound/en_right_01.m4a"
        Swedish ->
            case direction of
                Left ->
                    "/assets/sound/se_left_01.m4a"
                Right ->
                    "/assets/sound/se_right_01.m4a"
        French ->
            case direction of
                Left ->
                    "/assets/sound/fr_left_01.m4a"
                Right ->
                    "/assets/sound/fr_right_01.m4a"
        Spanish ->
            case direction of
                Left ->
                    "/assets/sound/es_left_01.m4a"
                Right ->
                    "/assets/sound/es_right_01.m4a"


allLanguages : List Language
allLanguages =
    [ French
    , Swedish
    , English
    , Spanish
    ]
