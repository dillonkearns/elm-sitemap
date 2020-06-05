module Sitemap exposing (Entry, build)

{-| <https://www.sitemaps.org/protocol.html>

Including a sitemap can boost your SEO by making it easier for webcrawlers to efficiently crawl your site. It also helps
web crawlers detect when a change has been made on your site faster, so changes to your site can be reflected sooner
in search results.

Be sure to exclude pages from your site map that you don't want to be indexed. This is a good resource
that explains which pages should be included and which should be excluded: <https://blog.spotibo.com/sitemap-guide/#which-urls-should-be-put-in-a-sitemap>.

It's important that you not include duplicate pages in your sitemap as this can result in a serious SEO penalty or
flag your site as spam.

Here's another reference with more best practices: <https://support.google.com/webmasters/answer/183668?hl=en>

@docs Entry, build

-}

import Dict
import Path
import Xml
import Xml.Encode exposing (..)


{-| The data for a single entry in your sitemap.
-}
type alias Entry =
    { path : String
    , lastMod : Maybe String
    }


{-| Generate a String in XML format for your sitemap.
-}
build :
    { siteUrl : String
    }
    -> List Entry
    -> String
build { siteUrl } urls =
    object
        [ ( "urlset"
          , Dict.fromList
                [ ( "xmlns", string "http://www.sitemaps.org/schemas/sitemap/0.9" )
                ]
          , urls
                |> List.map (urlXml siteUrl)
                |> list
          )
        ]
        |> encode 0


urlXml siteUrl entry =
    object
        [ ( "url"
          , Dict.empty
          , [ string (Path.join [ siteUrl, entry.path ])
                |> keyValue "loc"
                |> Just
            , entry.lastMod
                |> Maybe.map string
                |> Maybe.map (keyValue "lastmod")
            ]
                |> List.filterMap identity
                |> list
          )
        ]


keyValue : String -> Xml.Value -> Xml.Value
keyValue key value =
    object [ ( key, Dict.empty, value ) ]
