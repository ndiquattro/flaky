test_that("Unfound DSN throws an error", {
  expect_error(flaky_connect("fdkla;"))
})

test_that("Missing connection_string and DSN throws correct error", {
  expect_error(flaky_connect(), "No credentials were provided. Set dsn or connection_string argument.")
})
