module Model exposing (..)


import Time exposing (Time)
import Window exposing (Size)


type Direction =
    Left
    | Right

type alias Model =
    { direction: Direction
    , lastDirection: Direction
    , correctGuess: Bool
    , windowSize: Size
    , directionClickedTime: Time
    , time: Time
    }

type Msg =
    Tick Time
    | NewDirection Direction
    | Resize Size
    | DirectionClicked Direction
