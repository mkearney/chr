
#' Extract matches from strings
#'
#' Detect and return all matching patterns from character vector.
#'
#' @param x Character vector
#' @param pat Pattern (regex) to extract from text.
#' @param ignore.case Logical indicating whether to ignore capitalization.
#'   Defaults to false.
#' @param collapse Text inserted between extracted matches. If non-null (the
#'   default) a vector of matches is returned for each inputted string.
#' @param invert Logical indicating whether to extract matching portion
#'   (default) or, if this value is true, non-matching portions of text.
#' @param na Logical indicating whether to return NA values for input elements
#'   without matches. Defaults to true.
#' @param ... Other named arguments passed to \code{\link{gregexpr}}.
#' @return Vector of matches extracted from input text.
#' @export
chr_extract <- function(x, pat,
                        ignore.case = FALSE,
                        collapse = NULL,
                        invert = FALSE,
                        na = TRUE,
                        ...) {
  UseMethod("chr_extract")
}

#' @export
chr_extract.default <- function(x, pat,
                                ignore.case = FALSE,
                                collapse = NULL,
                                invert = FALSE,
                                na = TRUE,
                                ...) {
  stopifnot(is.atomic(x))
  m <- gregexpr(pat, x, ignore.case = ignore.case, ...)
  x <- regmatches(x, m, invert = invert)
  if (na) {
    x[lengths(x) == 0] <- NA_character_
  }
  if (isTRUE(collapse)) collapse <- " "
  if (isFALSE(collapse)) collapse <- NULL
  if (!is.null(collapse)) {
    y <- lengths(x) > 1L
    x[y] <- vapply(
      x[y], paste, collapse = collapse,
      character(1), USE.NAMES = FALSE)
    x <- as.character(x)
  }
  x
}

#' @export
chr_extract.list <- function(x, pat,
                             ignore.case = FALSE,
                             collapse = NULL,
                             invert = FALSE,
                             na = TRUE,
                             ...) {
  x <- lapply(
    x, chr_extract, pat = pat, ignore.case = ignore.case,
    collapse = collapse, invert = invert, na = na, ...)
  lapply(x, unlist, recursive = FALSE)
}

#' Extract first match from strings
#'
#' Detect and return first matching pattern from character vector.
#'
#' @param x Character vector
#' @param pat Pattern (regex) to extract from text.
#' @param ignore.case Logical indicating whether to ignore capitalization.
#'   Defaults to false.
#' @param invert Logical indicating whether to extract matching portion
#'   (default) or, if this value is true, non-matching portions of text.
#' @param na Logical indicating whether to return NA values for input elements
#'   without matches. Defaults to true.
#' @param ... Other named arguments passed to \code{\link{regexpr}}.
#' @return Character vector of matches extracted from input text.
#' @export
chr_extract_first <- function(x, pat,
                              ignore.case = FALSE,
                              invert = FALSE,
                              na = TRUE,
                              ...) {
  UseMethod("chr_extract_first")
}



#' @export
chr_extract_first.default <- function(x, pat,
                                      ignore.case = FALSE,
                                      invert = FALSE,
                                      na = TRUE,
                                      ...) {
  stopifnot(is.atomic(x))
  m <- regexpr(pat, x, ignore.case = ignore.case, ...)
  x <- regmatches(x, m, invert = invert)
  if (na) {
    x[lengths(x) == 0] <- NA_character_
  }
  as.character(x)
}

#' @export
chr_extract_first.list <- function(x, pat,
                                   ignore.case = FALSE,
                                   na = TRUE,
                                   ...) {
  x <- lapply(
    x, chr_extract_first, pat = pat, ignore.case = ignore.case,
    na = na, ...)
  lapply(x, unlist, recursive = FALSE)
}


#' Extract URL links from text
#'
#' Extracts all hyper-links from character vector.
#'
#' @param x Character vector.
#' @param collapse Text inserted between extracted matches. If non-null (the
#'   default) a vector of matches is returned for each inputted string.
#' @return Vector of URLs.
#' @export
chr_extract_links <- function(x, collapse = NULL) {
  chr_extract(x, "https?\\S+", collapse = collapse)
}



#' Extract words from text
#'
#' Extracts all words from character vector.
#'
#' @param x Character vector.
#' @return Vector of words.
#' @export
chr_extract_words <- function(x) {
  ## standardize apostrophes
  x <- gsub(
    "[[:alpha:]]+(\u2018|\u2019|\u05F3|\u02B9|\u02Bc|\u02C8|\u0301|\u05F3|\u2032|\uA78C)[[:alpha:]]+",
    "\u0027", x)
  chr_extract(x, "\\b[[:alnum:]]+\\b|\\b[[:alnum:]]+['-\\.]+[[:alnum:]]+\\b")
  ##chr_extract(x, "\\b[[:alpha:]]+[-']?[[:alpha:]]+\\b|\\b\\w\\b")
}

#' Extract [at] mentions from text
#'
#' Extracts all [at] mentions from character vector.
#'
#' @param x Character vector.
#' @return Vector of screen names.
#' @export
chr_extract_mentions <- function(x, collapse = NULL) {
  chr_extract(x, "(?<=@)\\w+", collapse = collapse, perl = TRUE)
}

#' Extract hashtags from text
#'
#' Extracts all hashtags from character vector.
#'
#' @param x Character vector.
#' @return Vector of hashtags.
#' @export
chr_extract_hashtags <- function(x, collapse = NULL) {
  chr_extract(x, "(?<=#)\\w+", collapse = collapse, perl = TRUE)
}

chr_extract_phone <- function(x, collapse = NULL) {
  chr_extract(x, "([2-9][0-9]{2})[- .]([0-9]{3})[- .]([0-9]{4})", collapse = collapse)
}

