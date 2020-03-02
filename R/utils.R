get_ls_opts <- function(url, pattern) {
  lis <-
    httr::GET(url) %>%
    xml2::read_html() %>%
    rvest::html_nodes("span[class=doc]") %>%
    rvest::html_text()

  lis <-
    lis[str_which(lis, pattern)] %>%
    str_remove(pattern) %>%
    unique() %>%
    sort() %>%
    tolower()

  tibble(name = lis)
}
