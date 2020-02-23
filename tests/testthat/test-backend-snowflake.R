test_that("custom stringr functions translated correctly", {

  trans <- function(x) {
    dbplyr::translate_sql(!!rlang::enquo(x), con = dbplyr::simulate_dbi("Snowflake"))
  }

  expect_equal(trans(str_detect(x, y)), dbplyr::sql("CONTAINS(`x`, `y`)"))
  expect_equal(trans(str_detect(x, y, negate = TRUE)), dbplyr::sql("NOT(CONTAINS(`x`, `y`))"))

  expect_equal(trans(str_remove_all(x, y)), dbplyr::sql("REGEXP_REPLACE(`x`, `y`)"))

  expect_equal(trans(str_starts(x, y)), dbplyr::sql("STARTSWITH(`x`, `y`)"))
  expect_equal(trans(str_starts(x, y, negate = TRUE)), dbplyr::sql("NOT(STARTSWITH(`x`, `y`))"))

  expect_equal(trans(str_ends(x, y)), dbplyr::sql("ENDSWITH(`x`, `y`)"))
  expect_equal(trans(str_ends(x, y, negate = TRUE)), dbplyr::sql("NOT(ENDSWITH(`x`, `y`))"))
})
