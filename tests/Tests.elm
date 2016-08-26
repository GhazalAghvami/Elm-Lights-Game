module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import LightsGame


all : Test
all =
    describe "A Test Suite"
        [ test "can toggle a light" <|
            \() ->
                LightsGame.init [ True ]
                    |> LightsGame.update (LightsGame.Toggle 0)
                    |> .isOn
                    |> Expect.equal [ False ]
          --        , test "can toggle a light 2" <|
          --            \() ->
          --                Expect.equal [ False ] (.isOn (LightsGame.update (LightsGame.Toggle 0) (LightsGame.init [ True ])))
        , test "toggling a light toggles its right neighbor" <|
            \() ->
                LightsGame.init [ False, False, False ]
                    |> LightsGame.update (LightsGame.Toggle 0)
                    |> .isOn
                    |> Expect.equal [ True, True, False ]
        , test "toggling a light toggles its left neighbor" <|
            \() ->
                LightsGame.init [ False, False, False ]
                    |> LightsGame.update (LightsGame.Toggle 2)
                    |> .isOn
                    |> Expect.equal [ False, True, True ]
        ]
