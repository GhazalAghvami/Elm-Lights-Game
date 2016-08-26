module Tests exposing (..)

import Test exposing (..)
import Expect
import String
import LightsGame
import Matrix exposing (Matrix)


all : Test


singleLightBoard =
    Matrix.fromList [ [ True ] ]
        |> Maybe.withDefault Matrix.empty


singleRowBoard =
    Matrix.fromList [ [ False, False, False ] ]
        |> Maybe.withDefault Matrix.empty


squareBoard =
    Matrix.fromList
        [ [ False, False, False ] ]
        [ [ False, False, False ] ]
        [ [ False, False, False ] ]


all =
    describe "A Test Suite"
        [ test "can toggle a light" <|
            \() ->
                LightsGame.init singleLightBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                    |> .isOn
                    |> Matrix.get 0 0
                    |> Expect.equal [ Just False ]
          --        , test "can toggle a light 2" <|
          --            \() ->
          --                Expect.equal [ False ] (.isOn (LightsGame.update (LightsGame.Toggle 0) (LightsGame.init [ True ])))
        , test "toggling a light toggles its right neighbor" <|
            \() ->
                LightsGame.init singleRowBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                    |> .isOn
                    |> Matrix.get 1 0
                    |> Expect.equal [ Just True ]
        , test "toggling a light toggles its left neighbor" <|
            \() ->
                LightsGame.init singleRowBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 0, y = 0 })
                    |> .isOn
                    |> Matrix.get 1 0
                    |> Expect.equal [ Just True ]
        , test "toggling a light doesnt toggle non-neighbors" <|
            \() ->
                LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 1, y = 1 })
                    |> .isOn
                    |> Matrix.get 0 0
                    |> Expect.equal [ Just False ]
        , test "toggling a light toggles upperneighbors" <|
            \() ->
                LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 1, y = 2 })
                    |> .isOn
                    |> Matrix.get 1 1
                    |> Expect.equal [ Just True ]
        , test "toggling a light toggles lower neighbor" <|
            \() ->
                LightsGame.init squareBoard
                    |> LightsGame.update (LightsGame.Toggle { x = 1, y = 0 })
                    |> .isOn
                    |> Matrix.get 1 1
                    |> Expect.equal [ Just True ]
        ]
