module PathTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Path
import Sitemap
import Test exposing (..)


suite : Test
suite =
    describe "generated xml"
        [ test "empty list" <|
            \() ->
                Path.join []
                    |> Expect.equal ""
        , test "single url" <|
            \() ->
                Path.join [ "https://example.com" ]
                    |> Expect.equal "https://example.com"
        , test "append relative url" <|
            \() ->
                Path.join [ "https://example.com", "about" ]
                    |> Expect.equal "https://example.com/about"
        , test "append absolute url to base with trailing slash" <|
            \() ->
                Path.join [ "https://example.com/", "/about" ]
                    |> Expect.equal "https://example.com/about"
        ]
