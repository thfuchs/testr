# cfgoTest

![lint](https://github.com/cfgo/cfgoTest/workflows/R-CMD-Production/badge.svg)
![lint](https://github.com/cfgo/cfgoTest/workflows/R-CMD-Windows/badge.svg)
![lint](https://github.com/cfgo/cfgoTest/workflows/covr/badge.svg)
![lint](https://github.com/cfgo/cfgoTest/workflows/lint/badge.svg)

[![minimal R
version](https://img.shields.io/badge/R%3E%3D-3.6.0-6666ff.svg)](https://cran.r-project.org/)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![packageversion](https://img.shields.io/badge/Package%20version-0.0.1-orange.svg?style=flat-square)](commits/master)

## What is cfgoTest for?
For testing R Packages, CFgO uses the [tinytest](https://github.com/markvanderloo/tinytest) Framework.  
`cfgoTest` therefore provides additional assisting functions to help testing, in particular unit testing (currently).

## How is cfgoTest related to other cfgo packages?
`cfgoTest` is one of the base packages with no dependencies across other cfgo packages.

While serving as basic testing framework, most other packages depend on it. As experimental status basge suggests, this "framework" is just implemented and could be used for several further testing purposes including [`shiny::testServer()`](https://github.com/rstudio/shiny) for integration tests or [`dittodb`](https://github.com/ropensci/dittodb) for database mocking functions.

## On which packages does cfgoTest depends on?
- `rlang`,
- `stringr`,
- `magrittr`,
- `tinytest`

## Additional Information

