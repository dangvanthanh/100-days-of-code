module Main exposing (Model, Msg(..), draggableItemView, itemView, main, model, onDragEnd, onDragOver, onDragStart, onDrop, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events as Events
import Json.Decode as Decode


onDragStart msg =
    Events.on "dragstart" <|
        Decode.succeed msg


onDragEnd msg =
    Events.on "dragend" <|
        Decode.succeed msg


onDragOver msg =
    Events.onWithOptions "dragover"
        { stopPropagation = False
        , preventDefault = True
        }
    <|
        Decode.succeed msg


onDrop msg =
    Events.onWithOptions "drop"
        { stopPropagation = False
        , preventDefault = True
        }
    <|
        Decode.succeed msg


type alias Model =
    { beingDragged : Maybe String
    , draggableItems : List String
    , items : List String
    }


model : Model
model =
    { beingDragged = Nothing
    , draggableItems = List.range 1 5 |> List.map toString
    , items = []
    }


type Msg
    = Drag String
    | DragEnd
    | DragOver
    | Drop


update : Msg -> Model -> Model
update msg model =
    case msg of
        Drag item ->
            { model | beingDragged = Just item }

        DragEnd ->
            { model | beingDragged = Nothing }

        DragOver ->
            model

        Drop ->
            case model.beingDragged of
                Nothing ->
                    model

                Just item ->
                    { model
                        | beingDragged = Nothing
                        , items = item :: model.items
                    }


draggableItemView : String -> Html Msg
draggableItemView item =
    div
        [ class "card fluid warning"
        , draggable "true"
        , onDragStart <| Drag item
        , onDragEnd DragEnd
        ]
        [ div [ class "section" ]
            [ text item ]
        ]


itemView : String -> Html Msg
itemView item =
    div [ class "card fluid error" ]
        [ div [ class "section" ]
            [ text item ]
        ]


view : Model -> Html Msg
view model =
    div [ class "container" ]
        [ div [ class "row" ]
            [ div [ class "col-sm-6" ] <|
                (List.map draggableItemView model.draggableItems
                    |> (::)
                        (h4 []
                            [ text "Draggable" ]
                        )
                )
            , div
                [ class "col-sm-6"
                , onDragOver DragOver
                , onDrop Drop
                ]
              <|
                (List.map itemView model.items
                    |> (::)
                        (h4 []
                            [ text "Dropzone" ]
                        )
                )
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
