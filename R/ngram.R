

#' Character n-grams
#'
#' Returns n-grams at the character level
#'
#' @param x Character vector
#' @param n Number of characters to return per ngram
#' @param lower Logical indicating whether to lower case all text, defaults to
#'   false.
#' @param space Logical indicating whether to strip space, defaults to false.
#' @param punct Logical indicating whether to strip punctation, defaults to
#'   false.
#'
#' @return List of length equal to input length consisting of ngram vectors.
#' @export
#' @author ChrisMuir
#' @details Thanks to ChrisMuir \(https://github.com/mkearney/chr/issues/1)
chr_ngram_char <- function(x, n = 3, lower = FALSE, space = FALSE, 
                           punct = FALSE) {
  # Input validation
  stopifnot(is.character(x))
  if (n != as.integer(n) || n < 1) {
    stop("arg 'n' must be a whole number greater than zero")
  }
  n <- as.integer(n)
  stopifnot(is.logical(lower))
  stopifnot(is.logical(punct))
  stopifnot(is.logical(space))

  # If arg "lower" is TRUE, make all chars in x lowercase.
  if (isTRUE(lower)) x <- tolower(x)

  # If arg "punct" is TRUE, remove all punctuation from x.
  if (isTRUE(punct)) x <- gsub("[[:punct:]]", "", x)

  # If arg "space" is TRUE, remove all white space from x.
  if (isTRUE(space)) x <- gsub("\\s+", "", x)

  # Split each element of x into individual chars.
  x <- strsplit(x, "", fixed = TRUE)

  # If n is 1L, return x, as strsplit handles tokenization into single
  # chars.
  if (identical(n, 1L)) return(x)

  # Generate ngram tokens.
  n <- n - 1
  lapply(x, function(strings) {
    strings_len <- length(strings) - n
    if (is.na(strings) || strings_len < 0) return(character())
    vapply(seq_len(strings_len), function(char) {
      paste(strings[char:(char + n)], collapse = "")
    }, character(1))
  })
}
