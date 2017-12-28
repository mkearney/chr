#' Replace text pattern with string
#'
#' Replaces all matching patterns with user-provided string.
#'
#' @param x Character vector.
#' @param m Matching text or regular expression usd to locate text to be
#'   replaced.
#' @param r Replacement text, the length of which must be either one (a single
#'   string used as the replacement text) or equal to the length of the supplied
#'   character vector
#' @param ignore.case Logical indicating whether to ignore capitalization,
#'   defaults to FALSE.
#' @param ... Other args passed on to \code{\link{gsub}}.
#' @return Vector without URLs.
#' @export
chr_replace <- function(x, m, r, ignore.case = FALSE, ...) {
  chr_replace_(x, m, r, ignore.case = ignore.case, ...)
}

chr_replace_ <- function(x, m, r, ignore.case, ...) {
  stopifnot(is.vector(x))
  if (is.list(x)) {
    chr_replace_list(x, m, r, ignore.case = ignore.case, ...)
  } else {
    chr_replace_default(x, m, r, ignore.case = ignore.case, ...)
  }
}

chr_replace_list <- function(x, m, r, ignore.case, ...) {
  stopifnot(is.character(m), is.character(r))
  if (length(m) > 1L && length(r) > 1L) {
    if (length(m) > 1L && length(m) != length(r)) {
      stop("length of matching patterns must be 1 or equal to length of replacement patterns")
    } else if (length(r) > 1L && length(r) != length(m)) {
      stop("length of replacement text must be 1 or equal to length of matching patterns")
    }
    Map(gsub, m, r, x, MoreArgs = list(ignore.case = ignore.case, ...), use.names = FALSE)
  } else {
    lapply(x, function(i) gsub(m, r, i, ignore.case = ignore.case, ...))
  }
}

chr_replace_default <- function(x, m, r, ignore.case, ...) {
  stopifnot(is.character(m), is.character(r))
  if (length(m) > 1L && length(r) > 1L) {
    if (length(m) > 1L && length(m) != length(r)) {
      stop("length of matching patterns must be 1 or equal to length of replacement patterns")
    } else if (length(r) > 1L && length(r) != length(m)) {
      stop("length of replacement text must be 1 or equal to length of matching patterns")
    }
    unlist(Map(gsub, m, r, x, MoreArgs = list(ignore.case = ignore.case, ...), use.names = FALSE))
  } else {
    gsub(m, r, x, ignore.case = ignore.case, ...)
  }
}





