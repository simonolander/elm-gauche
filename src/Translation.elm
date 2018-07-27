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
