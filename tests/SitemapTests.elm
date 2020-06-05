module SitemapTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Sitemap
import Test exposing (..)


suite : Test
suite =
    describe "generated xml"
        [ test "relative urls" <|
            \() ->
                Sitemap.build { siteUrl = "https://example.com" }
                    [ { path = "", lastMod = Nothing }
                    , { path = "about", lastMod = Nothing }
                    ]
                    |> Expect.equal "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n<url>\n<loc>https://example.com/</loc>\n</url>\n<url>\n<loc>https://example.com/about</loc>\n</url>\n</urlset>"
        , test "absolute urls" <|
            \() ->
                Sitemap.build { siteUrl = "https://example.com" }
                    [ { path = "/", lastMod = Nothing }
                    , { path = "/about", lastMod = Nothing }
                    ]
                    |> Expect.equal "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n<url>\n<loc>https://example.com/</loc>\n</url>\n<url>\n<loc>https://example.com/about</loc>\n</url>\n</urlset>"
        , test "trailing /'s" <|
            \() ->
                Sitemap.build { siteUrl = "https://example.com/" }
                    [ { path = "/", lastMod = Nothing }
                    , { path = "/about/", lastMod = Nothing }
                    ]
                    |> Expect.equal "<urlset xmlns=\"http://www.sitemaps.org/schemas/sitemap/0.9\">\n<url>\n<loc>https://example.com/</loc>\n</url>\n<url>\n<loc>https://example.com/about</loc>\n</url>\n</urlset>"
        ]
