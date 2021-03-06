% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/flaky_connect.R
\name{flaky_connect}
\alias{flaky_connect}
\title{Create a connection to a Snowflake instance}
\usage{
flaky_connect(dsn = NULL, connection_string = NULL, set_default = TRUE, ...)
}
\arguments{
\item{dsn}{Data Service Name as defined in `~/.odbc.ini`.}

\item{connection_string}{Semi-colon separated string of key=value pairs. See
Details for an example.}

\item{set_default}{Set connection to default for session.}

\item{...}{Additional ODBC keywords, these will be joined with the other
arguments to form the final connection string.}
}
\value{
A connection object.
}
\description{
Connect to Snowflake using a DSN or connection string.
}
\details{
If using `connection_string` it should be defined in the following structure:
`"<name>=<value>;<name2>=<value2>"`.
}
\examples{
\dontrun{
# For a DSN named warehouse
con <- flaky_connect("warehouse")

# If you need to temporarily connect to a different set of credentials
other_con <- flaky_connect("warehouse_2", set_default = FALSE)
}
}
\author{
Nick DiQuattro
}
\concept{connection functions}
