
#' Count matches from strings
#'
#' Count all pattern matches in character vector.
#'
#' @param x Character vector
#' @param pat Pattern (regex) to extract from text.
#' @param ignore.case Logical indicating whether to ignore capitalization.
#'   Defaults to false.
#' @param invert Logical indicating whether to extract matching portion
#'   (default) or, if this value is true, non-matching portions of text.
#' @param ... Other named arguments passed to \code{\link{gregexpr}}.
#' @return Vector of matches extracted from input text.
#' @export
chr_count <- function(x, pat,
                        ignore.case = FALSE,
                        invert = FALSE,
                        ...) {
  UseMethod("chr_count")
}

#' @export
chr_count.default <- function(x, pat,
                                ignore.case = FALSE,
                                invert = FALSE,
                                ...) {
  stopifnot(is.atomic(x))
  x <- gregexpr(pat, x, ignore.case = ignore.case, ...)
  vapply(x, function(y) sum(y > 0, na.rm = TRUE), integer(1))
}

#' @export
chr_count.list <- function(x, pat,
                             ignore.case = FALSE,
                             invert = FALSE,
                             ...) {
  x <- lapply(
    x, chr_count, pat = pat, ignore.case = ignore.case,
    invert = invert, ...)
  lapply(x, unlist, recursive = FALSE)
}

