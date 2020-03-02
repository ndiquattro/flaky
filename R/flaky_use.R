#' Use Snowflake objects
#'
#' Change active Snowflake objects like user, warehouse, database, etc.
#'
#' @param object The object type to use.
#' @param name Name of the desired object.
#' @param con Connection object to apply the use command towards.
#' @param db_name If changing schema to a different database, the desired database.
#'
#' @return
#' @export
#'
#' @examples
flaky_use <- function(object, name, con = getOption("flaky.con"), db_name) {
  sql_cmd <- paste("USE", object, name, sep = " ")

  if (!missing(db_name)) {
    stopifnot(object == "schema")
    sql_cmd <- paste("USE", object, paste0(db_name, ".", name), sep = " ")
  }

  res <- DBI::dbGetQuery(con, sql_cmd)
  invisible(res)
}

#' List possible use commands
#'
#' Parses Snowflake docs for use commands and provides as a tibble.
#'
#' @param pattern Pattern to detect in name of use command. Uses [stringr::str_detect()].
#'
#' @return tibble
#' @export
#'
#' @examples
#' \dontrun{
#'  # Return all shows
#'  flaky_use_ls()
#'
#'  # Find function ones
#'  flaky_use_ls("fun")
#' }
flaky_use_ls <- function(pattern) {
  show_url <- "https://docs.snowflake.net/manuals/sql-reference/sql/use.html"

  base_list <- get_ls_opts(show_url, "^USE ")

  if (!missing(pattern)) {
    return(dplyr::filter(base_list, stringr::str_detect(name, tolower(pattern))))
  }

  base_list
}
