module Main exposing (..)

import Html exposing (text)


type alias Item =
    { name : String
    , price : Float
    , qty : Int
    , discounted : Bool
    }


add : Int -> Int -> Int
add a b =
    a + b


result =
    -- add (add 1 2) 3
    -- add 1 2 |> add 4
    add 2 2 |> \a -> a % 2 == 0


counter =
    0


increment cnt amt =
    let
        localCount =
            cnt

        -- localCount =
        -- localCount + amt
    in
        localCount + amt


cart : List { name : String, price : Float, qty : number, discounted : Bool }
cart =
    [ { name = "Lemon", price = 0.5, qty = 1, discounted = False }
    , { name = "Apple", price = 1.0, qty = 5, discounted = False }
    , { name = "Pear", price = 1.25, qty = 10, discounted = False }
    ]


fiveOrMoreDiscount : Item -> Item
fiveOrMoreDiscount item =
    if item.qty >= 5 then
        { item
            | price = item.price * 0.6
            , discounted = True
        }
    else
        item


discount : Int -> Float -> Item -> Item
discount minQty discPtc item =
    if not item.discounted && item.qty >= minQty then
        { item
            | price = item.price * (1.0 - discPtc)
            , discounted = True
        }
    else
        item



-- newCart =
--     List.map fiveOrMoreDiscount cart


newCart =
    List.map ((discount 10 0.3) >> (discount 5 0.2)) cart


main : Html.Html msg
main =
    -- Html.text (toString result)
    text
        (toString newCart)
