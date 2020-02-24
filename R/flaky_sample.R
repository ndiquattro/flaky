flaky_sample <- function(.data, size, con = getOption("flaky.con")) {
 sample_sql <-
   dbplyr::build_sql(
    "SELECT * FROM (",
    dbplyr::sql_render(.data),
    ") sample (", size, "rows)",
    con = con
  )

 dplyr::tbl(con, sample_sql)
}
