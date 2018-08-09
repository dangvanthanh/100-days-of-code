module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes as SA


type alias Model =
    { n : Int
    }


init : Model
init =
    { n = 1 }


type Msg
    = Dec
    | Inc


update : Msg -> Model -> Model
update msg model =
    case msg of
        Dec ->
            { model | n = model.n + 1 }

        Inc ->
            { model | n = model.n - 1 }


view : Model -> Html Msg
view model =
    div []
        [ button [ type_ "button", onClick Dec ] [ Html.text "-" ]
        , div [] [ Html.text (toString model.n) ]
        , svg [ SA.width "400", SA.height "400", SA.viewBox "0 0 400 400" ] (numeral model.n)
        , button [ type_ "button", onClick Inc ] [ Html.text "+" ]
        ]


numeral : Int -> List (Svg msg)
numeral x =
    let
        dphi =
            2.0 * pi / (toFloat x)

        phis =
            List.map (\i -> (toFloat i) * dphi)
    in
        if x == 0 then
            [ circle [ SA.cx "50", SA.cy "50", SA.r "20", SA.stroke "black", SA.fill "none" ] [] ]
        else
            [ path [ SA.stroke "black", SA.d "M 50 30, L 50 70" ] [] ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = init
        , update = update
        , view = view
        }
