# testr

![R-CMD-check](https://github.com/thfuchs/testr/workflows/R-CMD-check/badge.svg)
![Code Coverage](https://github.com/thfuchs/testr/workflows/Code%20Coverage/badge.svg)
![lint](https://github.com/thfuchs/testr/workflows/lint/badge.svg)

[![minimal R
version](https://img.shields.io/badge/R%3E%3D-4.0.0-6666ff.svg)](https://cran.r-project.org/)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![packageversion](https://img.shields.io/badge/Package%20version-0.0.4-orange.svg?style=flat-square)](commits/master)

## What is testr for?
`testr` provides:
1. additional assisting functions to help testing, in particular unit testing (currently) and
2. testing snippets, see [snippets](inst/snippets) which are useful for writing unit tests with RStudio (see [here for more information](https://support.rstudio.com/hc/en-us/articles/204463668-Code-Snippets))

## On which packages does testr depends on?

|                |
| :------------- |
| `rlang`        |

## Additional Information
As experimental status basge suggests, this "framework" is just implemented and could be used for several further testing purposes including [`shiny::testServer()`](https://github.com/rstudio/shiny) for integration tests or [`dittodb`](https://github.com/ropensci/dittodb) for database mocking functions.
