module Questions exposing (..)


type alias Question =
    { question : String
    , answers : List String
    , correctAnswer : String
    }


oneQuestion : Question
oneQuestion =
    { question = "Multiple Choice"
    , answers = [ "A", "B", "C", "D" ]
    , correctAnswer = "A"
    }


twoQuestion : Question
twoQuestion =
    { question = "Inline choice"
    , answers = [ "AA", "AB", "AC", "AD" ]
    , correctAnswer = "AB"
    }


threeQuestion : Question
threeQuestion =
    { question = "Fill in the blank"
    , answers = [ "Earth", "Jupiter", "Mercury", "Mars" ]
    , correctAnswer = "Mars"
    }


fourQuestion : Question
fourQuestion =
    { question = "Extended text"
    , answers = [ "Pandora", "Athena", "Artemis", "Aphrodite" ]
    , correctAnswer = "Pandora"
    }


question : List Question
question =
    [ oneQuestion
    , twoQuestion
    , threeQuestion
    , fourQuestion
    ]
