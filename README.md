
<!-- README.md is generated from README.Rmd. Please edit that file -->

# lens2r

<!-- badges: start -->

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)

[![R CMD Check via
{tic}](https://github.com/sbalci/lens2r/workflows/R%20CMD%20Check%20via%20%7Btic%7D/badge.svg?branch=master)](https://github.com/sbalci/lens2r/actions)
[![Travis build
status](https://travis-ci.com/sbalci/lens2r.svg?branch=master)](https://travis-ci.com/sbalci/lens2r)
<!-- badges: end -->

The goal of lens2r is to get Lens.org scholar data into R environment.
You need Lens.org scholar API token to access data, you can [get one
here](https://www.lens.org/lens/user/subscriptions#scholar).

> Scholarly Search and Analysis  
> Lens serves over 200 million scholarly records, compiled and
> harmonised from Microsoft Academic, PubMed and Crossref, enhanced with
> UnPaywall open access information, CORE full text and links to ORCID.
> The full scholarly citation graph is provided for the first time as an
> open public resource.

🔬🔬🔬🔬 UNDER CONSTRUCTION 🛠⛔️⚠️🔩

## Installation

<!-- You can install the released version of lens2r from [CRAN](https://CRAN.R-project.org) with: -->

<!-- ``` r -->

<!-- install.packages("lens2r") -->

<!-- ``` -->

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("sbalci/lens2r")
```

## Examples

``` r
library(lens2r)
#> Loading required package: httr
#> Loading required package: jsonlite
#> Loading required package: magrittr

request <- '{
    "query": {
        "match_phrase": {
            "author.affiliation.name": "Harvard University"
        }
    },
    "size": 1,
    "sort": [{
        "year_published": "desc"
    }]
}'
data <- lens2r::get_scholarly_data(query = request)

output_content <- httr::content(data, "text")

output_flatten <- jsonlite::fromJSON(output_content, flatten = TRUE)

output_flatten_data <- output_flatten$data

output_flatten_data
#>               lens_id                          created publication_type
#> 1 040-450-672-971-619 2019-08-12T03:30:43.659000+00:00  journal article
#>                                                                          authors
#> 1 NA, Mark, Tushnet, M, magid, 1845306793, Harvard University, grid.38142.3c, US
#>                                                                                                title
#> 1 Institutions protecting constitutional democracy: Some conceptual and methodological preliminaries
#>   volume issue languages          references
#> 1     70     2        en 199-199-909-278-791
#>                                   fields_of_study
#> 1 Liberal democracy, Sociology, Law, Constitution
#>                                                                                                      source_urls
#> 1 html, html, https://www.utpjournals.press/doi/abs/10.3138/utlj.2019-05-27, https://muse.jhu.edu/article/731612
#>                                                                                                                                                                                                   abstract
#> 1 Chapter 9 of the South African Constitution refers to ‘institutions protecting constitutional democracy’ (IPDs). Contemporary constitution designers have written into new constitutions numerous suc...
#>   year_published references_count
#> 1           2020                1
#>                                      external_ids start_page end_page
#> 1 magid, doi, 2964660712, 10.3138/utlj.2019-05-27         95      106
#>   author_count            date_published                      source.title
#> 1            1 2020-03-01T00:00:00+00:00 University of Toronto Law Journal
#>   source.type            source.publisher        source.issn source.country
#> 1     Journal University of Toronto Press 00420220, 17101174         Canada
#>   source.asjc_codes                 source.asjc_subjects
#> 1        3308, 3312 Law, Sociology and Political Science

output_flatten <- as.data.frame(output_flatten)

output_flatten
#>    total        data.lens_id                     data.created
#> 1 446110 040-450-672-971-619 2019-08-12T03:30:43.659000+00:00
#>   data.publication_type
#> 1       journal article
#>                                                                     data.authors
#> 1 NA, Mark, Tushnet, M, magid, 1845306793, Harvard University, grid.38142.3c, US
#>                                                                                           data.title
#> 1 Institutions protecting constitutional democracy: Some conceptual and methodological preliminaries
#>   data.volume data.issue data.languages     data.references
#> 1          70          2             en 199-199-909-278-791
#>                              data.fields_of_study
#> 1 Liberal democracy, Sociology, Law, Constitution
#>                                                                                                 data.source_urls
#> 1 html, html, https://www.utpjournals.press/doi/abs/10.3138/utlj.2019-05-27, https://muse.jhu.edu/article/731612
#>                                                                                                                                                                                              data.abstract
#> 1 Chapter 9 of the South African Constitution refers to ‘institutions protecting constitutional democracy’ (IPDs). Contemporary constitution designers have written into new constitutions numerous suc...
#>   data.year_published data.references_count
#> 1                2020                     1
#>                                 data.external_ids data.start_page data.end_page
#> 1 magid, doi, 2964660712, 10.3138/utlj.2019-05-27              95           106
#>   data.author_count       data.date_published                 data.source.title
#> 1                 1 2020-03-01T00:00:00+00:00 University of Toronto Law Journal
#>   data.source.type       data.source.publisher   data.source.issn
#> 1          Journal University of Toronto Press 00420220, 17101174
#>   data.source.country data.source.asjc_codes
#> 1              Canada             3308, 3312
#>              data.source.asjc_subjects results
#> 1 Law, Sociology and Political Science       1
```

## Similar Works

### lensr

A package to access patent data from the Lens Patent Database Deprecated

<https://github.com/poldham/lensr>

### covidlens

<https://github.com/poldham/covidlens>

Scientific and Patent Literature on Covid-19 Corona Virus from the Lens
for R <https://poldham.github.io/covidlens/>

### R codes in Lens.org API documentation

<https://docs.api.lens.org/samples.html#r>

These are the basic codes this package uses

``` r
require(httr)
getScholarlyData <- function(token, query){
    url <- 'https://api.lens.org/scholarly/search'
    headers <- c('Authorization' = token, 'Content-Type' = 'application/json')
    httr::POST(url = url, add_headers(.headers=headers), body = query)
}
token <- 'your-access-token'
request <- '{
    "query": {
        "match_phrase": {
            "author.affiliation.name": "Harvard University"
        }
    },
    "size": 1,
    "sort": [{
        "year_published": "desc"
    }]
}'
data <- getScholarlyData(token, request)
content(data, "text")
```

-----

<a class="twitter-follow-button" data-show-count="false" href="https://twitter.com/serdarbalci">Follow
@serdarbalci</a>

<script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>

<a class="bmc-button" target="_blank" href="https://www.buymeacoffee.com/bS0teIs"><img src="https://cdn.buymeacoffee.com/buttons/bmc-new-btn-logo.svg" alt="Buy me a coffee"><span style="margin-left:15px;font-size:28px !important;">Buy
me a coffee</span></a>

<https://paypal.me/serdarbalci>

-----

<img src="https://cdn.buymeacoffee.com/buttons/arial-orange.png" alt="Buy Me A Coffee" style="height: 51px !important;width: 217px !important;" ></a>  
![Twitter
Follow](https://img.shields.io/twitter/follow/serdarbalci?style=social)
![GitHub
followers](https://img.shields.io/github/followers/sbalci?style=social)
[![Say
Thanks\!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://saythanks.io/to/sbalci)

## Development Status

[![Project Status: WIP – Initial development is in progress, but there
has not yet been a stable, usable release suitable for the
public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip)
[![R CMD Check via
{tic}](https://github.com/sbalci/lens2r/workflows/R%20CMD%20Check%20via%20%7Btic%7D/badge.svg?branch=master)](https://github.com/sbalci/lens2r/actions)
[![Travis build
status](https://travis-ci.com/sbalci/lens2r.svg?branch=master)](https://travis-ci.com/sbalci/lens2r)
