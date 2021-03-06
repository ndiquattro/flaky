% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flaky_remove.R
\name{flaky_remove}
\alias{flaky_remove}
\title{Remove data from Snowflake}
\usage{
flaky_remove(table_schema, table_name, ..., con = getOption("flaky.con"))
}
\arguments{
\item{table_schema}{Name of target schema.}

\item{table_name}{Name of target table.}

\item{...}{Additional parameters to pass on to [DBI::dbRemoveTable()].}

\item{con}{A connection object. Typically generated by [flaky_connect()].}
}
\description{
Remove a table from Snowflake. Ensures schema and table names are uppercase.
}
\examples{
\dontrun{
flaky_remove(table_schema = "rdata", table_name = "mtcars")
}
}
