#' Detect matches in strings
#'
#' Detect matching pattern in character vector.
#'
#' @param x Character vector
#' @param pat Pattern (regex) to detect from text.
#' @param ignore.case Logical indicating whether to ignore capitalization.
#'   Defaults to false.
#' @param ... Other named arguments passed to \code{\link{grepl}} or \code{\link{grep}}
#'   See details for more information.
#' @return Logical vector indicating whether each element matched the supplied pattern.
#' @details This is a wrapper around the base R functions \code{\link{grepl}} and
#'   \code{\link{grep}}. By default, logical values are returned (a la grepl). To return
#'   values, include \code{value = TRUE}. To return positions, include \code{which = TRUE},
#'   \code{pos = TRUE}, or \code{position = TRUE}.
#' @examples
#'
#' ## return logical vector
#' chr_detect(letters, "a|b|c|x|y|z")
#'
#' ## return inverted logical values
#' chr_detect(letters, "a|b|c|x|y|z", invert = TRUE)
#'
#' ## return matching positions
#' chr_detect(letters, "a|b|c|x|y|z", which = TRUE)
#'
#' ## return inverted matching positions
#' chr_detect(letters, "a|b|c|x|y|z", which = TRUE, invert = TRUE)
#'
#' ## return matching values
#' chr_detect(letters, "a|b|c|x|y|z", value = TRUE)
#'
#' ## return inverted matching values
#' chr_detect(letters, "a|b|c|x|y|z", value = TRUE, invert = TRUE)
#' @export
chr_detect <- function(x, pat, ignore.case = FALSE, ...) {
  UseMethod("chr_detect")
}


#' @export
chr_detect.default <- function(x, pat, ignore.case = FALSE, ...) {
  args <- list(pat, x, ignore.case = ignore.case, ...)
  ## if look behind/ahead and perl not specified, set perl to TRUE
  if (grepl("\\(\\?[^\\)]+\\)", x) && !"perl" %in% names(x)) {
    dots$perl <- TRUE
  }
  if (any(c("which", "pos", "position", "value") %in% names(args))) {
    args <- args[!names(args) %in% c("which", "pos", "position")]
    do.call("grep", args)
  } else {
    if ("invert" %in% names(args) && isTRUE(args$invert)) {
      tf <- `!`
    } else {
      tf <- identity
    }
    args <- args[!names(args) %in% c("invert")]
    tf(do.call("grepl", args))
  }
}


#' @export
chr_detect.list <- function(x, pat, ignore.case = FALSE, ...) {
  x <- lapply(x, chr_detect, pat = pat, ignore.case = ignore.case, ...)
  lapply(x, unlist, recursive = FALSE)
}
