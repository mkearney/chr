#' Detect matches in strings
#'
#' Detect matching pattern in character vector.
#'
#' @param x Character vector
#' @param pat Pattern (regex) to detect from text.
#' @param ignore.case Logical indicating whether to ignore capitalization.
#'   Defaults to false.
#' @param ... Other named arguments passed to \code{\link{grepl}}.
#' @return Logical vector indicating whether each element matched the supplied pattern.
#' @export
chr_detect <- function(x, pat, ignore.case = FALSE, ...) {
  UseMethod("chr_detect")
}

#' @export
chr_detect.default <- function(x, pat, ignore.case = FALSE, ...) {
  grepl(pat, x, ignore.case = ignore.case, ...)
}

#' @export
chr_detect.list <- function(x, pat, ignore.case = FALSE, ...) {
  x <- lapply(x, chr_detect, pat = pat, ignore.case = ignore.case, ...)
  lapply(x, unlist, recursive = FALSE)
}
