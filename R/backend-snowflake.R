#' @export
sql_translate_env.Snowflake <- function(con) {
  dbplyr::sql_variant(
    base_snowflake_scalar,
    base_snowflake_agg,
    base_snowflake_win
  )
}

base_snowflake_scalar <-
  dbplyr::sql_translator(
    .parent = dbplyr::base_odbc_scalar,

    # Stringr Functions -----
    str_detect = function(string, pattern, negate = FALSE) {
      if (negate) {
        return(dbplyr::sql_expr(NOT(CONTAINS(!!string, !!pattern))))
      }

      dbplyr::sql_expr(CONTAINS(!!string, !!pattern))
    },

    str_remove_all = function(string, pattern) {
      dbplyr::sql_expr(REGEXP_REPLACE(!!string, !!pattern))
    },

    str_starts = function(string, pattern, negate = FALSE) {
      if (negate) {
        return(dbplyr::sql_expr(NOT(STARTSWITH(!!string, !!pattern))))
      }

      dbplyr::sql_expr(STARTSWITH(!!string, !!pattern))
    },

    str_ends = function(string, pattern, negate = FALSE) {
      if (negate) {
        return(dbplyr::sql_expr(NOT(ENDSWITH(!!string, !!pattern))))
      }

      dbplyr::sql_expr(ENDSWITH(!!string, !!pattern))
    }
)

base_snowflake_agg <-
  dbplyr::sql_translator(
    .parent = dbplyr::base_odbc_agg,

    cor = dbplyr::sql_prefix("CORR"),
    cov = dbplyr::sql_prefix("COVAR_SAMP"),
    sd =  dbplyr::sql_prefix("STDDEV_SAMP"),
    var = dbplyr::sql_prefix("VAR_SAMP"),
    # all = dbplyr::sql_prefix("bool_and"),  # As found in snowflake repo
    # any = dbplyr::sql_prefix("bool_or"),
    paste = function(x, collapse)
      dbplyr::build_sql("LISTAGG(", x, collapse, ")")
    )

base_snowflake_win <-
  dbplyr::sql_translator(
    .parent = dbplyr::base_odbc_win,

    cor = dbplyr::sql_prefix("CORR"),
    cov = dbplyr::sql_prefix("COVAR_SAMP"),
    sd =  dbplyr::sql_prefix("STDDEV_SAMP"),
    var = dbplyr::sql_prefix("VAR_SAMP"),
    # all = dbplyr::sql_prefix("bool_and"),  # As found in snowflake repo
    # any = dbplyr::sql_prefix("bool_or"),
    paste = function(x, collapse)
      dbplyr::build_sql("LISTAGG(", x, collapse, ")")
  )
