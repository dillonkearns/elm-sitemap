# `elm-sitemap` [![Elm package](https://img.shields.io/elm-package/v/dillonkearns/elm-sitemap.svg)](https://package.elm-lang.org/packages/dillonkearns/elm-sitemap/latest/)

A simple interface for building a String of an XML sitemap from structured elm data, following the [sitemap protocol](https://www.sitemaps.org/protocol.html).

*Note*: this package was built as utility for [`elm-pages`](https://github.com/dillonkearns/elm-pages) apps,
and it may be become more coupled to `elm-pages` over time.

## Example
Here's an example from an `elm-pages` app.

```elm
import Metadata exposing (Metadata(..)) -- this is the user's metadata custom type
import Pages
import Pages.PagePath as PagePath exposing (PagePath)
import Sitemap

build :
    { siteUrl : String
    }
    ->
        List
            { path : PagePath Pages.PathKey
            , frontmatter : Metadata
            , body : String
            }
    ->
        { path : List String
        , content : String
        }
build config siteMetadata =
    { path = [ "sitemap.xml" ]
    , content =
        Sitemap.build config
            (siteMetadata
                |> List.map
                    (\page ->
                        { path = PagePath.toString page.path
                        , lastMod = Nothing }
                    )
            )
    }
```
