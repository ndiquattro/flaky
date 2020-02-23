#' Create a connection to a Snowflake instance
#'
#' Connect to Snowflake using a DSN or connection string.
#'
#' If using `connection_string` it should be defined in the following structure: `"<name>=<value>;<name2>=<value2>"`.
#'
#' @param dsn Data Service Name as defined in `~/.odbc.ini`.
#' @param connection_string Semi-colon separated string of key=value pairs. See Details for an example.
#' @param set_default Set connection to default for session.
#' @param ... Additional ODBC keywords, these will be joined with the other arguments to form the final connection string.
#'
#' @return A connection object.
#'
#' @author Nick DiQuattro
#'
#' @family connection functions
#'
#' @examples
#' \donttest{
#' # For a DSN named warehouse
#' con <- flaky_connect("warehouse")
#'
#' # If you need to temporarily connect to a different set of credentials
#' other_con <- flaky_connect("warehouse_2", set_default = FALSE)
#'}
#' @export
flaky_connect <- function(dsn = NULL, connection_string = NULL,
                          set_default = TRUE, ...) {
  # Check credentials type
  if (is.null(dsn) & is.null(connection_string)) {
    stop("No credentials were provided. Set dsn or connection_string argument.")
  }

  # Make connection
  con <-
    DBI::dbConnect(
      drv = odbc::odbc(),
      dsn = dsn,
      .connection_string = connection_string,
      ...
    )

  # Set default option
  if (set_default) {
    options(list(flaky.con = con))
  }

  return(con)
}
