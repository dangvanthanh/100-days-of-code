module Main exposing (..)

import Html exposing (..)
import Html.Attributes
import Html.Events exposing (onClick)
import List
import Random
import Svg exposing (..)
import Svg.Attributes exposing (..)


-- model


type alias Model =
    { diceFace : Int
    }


init : ( Model, Cmd Msg )
init =
    ( Model 2, Cmd.none )



-- update


type Msg
    = Roll
    | NewFace Int


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Roll ->
            ( model, Random.generate NewFace (Random.int 1 6) )

        NewFace newFace ->
            ( Model newFace, Cmd.none )



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- view


view : Model -> Html Msg
view model =
    div []
        [ svg
            [ width "120"
            , height "120"
            , viewBox "0 0 120 120"
            , fill "white"
            , stroke "black"
            , strokeWidth "3"
            , Html.Attributes.style [ ( "padding-left", "20px" ) ]
            ]
            (List.append
                [ rect
                    [ x "1"
                    , y "1"
                    , width "100"
                    , height "100"
                    , rx "15"
                    , ry "15"
                    ]
                    []
                ]
                (svgCirclesForDiceFace model.diceFace)
            )
        , button [ onClick Roll ] [ Html.text "Roll" ]
        ]


svgCirclesForDiceFace : Int -> List (Svg Msg)
svgCirclesForDiceFace diceFace =
    case diceFace of
        1 ->
            [ circle [ cx "50", cy "50", r "10", fill "black" ] [] ]

        2 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        3 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "50", cy "50", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        4 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "25", r "10", fill "black" ] []
            , circle [ cx "25", cy "75", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            ]

        5 ->
            [ circle [ cx "25", cy "25", r "10", fill "black" ] []
            , circle [ cx "75", cy "25", r "10", fill "black" ] []
            , circle [ cx "25", cy "75", r "10", fill "black" ] []
            , circle [ cx "75", cy "75", r "10", fill "black" ] []
            , circle [ cx "50", cy "50", r "10", fill "black" ] []
            ]

        6 ->
            [ circle [ cx "25", cy "20", r "10", fill "black" ] []
            , circle [ cx "25", cy "50", r "10", fill "black" ] []
            , circle [ cx "25", cy "80", r "10", fill "black" ] []
            , circle [ cx "75", cy "20", r "10", fill "black" ] []
            , circle [ cx "75", cy "50", r "10", fill "black" ] []
            , circle [ cx "75", cy "80", r "10", fill "black" ] []
            ]

        _ ->
            [ circle [ cx "50", cy "50", r "50", fill "red", stroke "none" ] [] ]



-- main


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
