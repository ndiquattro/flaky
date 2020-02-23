
<!-- README.md is generated from README.Rmd. Please edit that file -->

# flaky

<!-- badges: start -->

<!-- badges: end -->

The goal of flaky is to provide a dplyr backend and various helpers for
using [Snowflake](https://www.snowflake.com/) with R. You may know about
Snowflake’s similar package
[dplyr.snowflakedb](https://github.com/snowflakedb/dplyr-snowflakedb),
but that requires rJava, a notriously difficult package to use. Flaky is
meant to be use with Snowflake’s ODBC drivers which work well within the
Rstudio environment, once you [get them
installed](https://www.ndiquattro.me/blog/2020/02/snowflake-r-and-dbplyr/).

## Installation

Currently, flaky is only available through [GitHub](https://github.com/)
with:

``` r
# install.packages("remotes")
remotes::install_github("ndiquattro/flaky")
```

## Example

``` r
library(dplyr)
library(flaky)

con <- flaky_connect("snowflake_dsn")

con %>% 
  tbl(dbplyr::in_schema("schema", "table")) %>% 
  filter(coolness > 10, str_detect(rpackages, "flak")) %>% 
  collect()
```
