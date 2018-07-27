module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    { playing : Bool
    , src : String
    }


model : Model
model =
    { playing = False
    , src = "http://stream-tx4.radioparadise.com/mp3-192"
    }



-- update


type Msg
    = Play
    | Pause


update : Msg -> Model -> Model
update msg model =
    case msg of
        Play ->
            { model | playing = True }

        Pause ->
            { model | playing = False }



-- view


view : Model -> Html Msg
view model =
    if model.playing then
        playingView model
    else
        notPlayingView model


notPlayingView : Model -> Html Msg
notPlayingView model =
    button [ onClick Play ] [ text "Play" ]


playingView : Model -> Html Msg
playingView model =
    div []
        [ button [ onClick Pause ] [ text "Pause" ]
        , audio [ src model.src, autoplay True, controls True ] []
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
