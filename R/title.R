
#' Convert string to title case
#'
#' Capitalize character vector using title case
#'
#' @param x Character vector.
#' @return Character vector in title case.
#' @export
title_case <- function(x) {
  m <- regexpr("\\b[a-z]{1}", x)
  regmatches(x, m) <- toupper(regmatches(x, m))
  x
}
