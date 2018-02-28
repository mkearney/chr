#' Remove URL links from text
#'
#' Removes all hyper-links from character vector.
#'
#' @param x Character vector.
#' @return Vector without URLs.
#' @export
chr_remove_links <- function(x) {
  gsub("https?:[[:graph:]]+", "", x)
}

#' Remove line breaks from text
#'
#' Removes all line breaks from character vector.
#'
#' @param x Character vector.
#' @return Vector without line breaks.
#' @export
chr_remove_linebreaks <- function(x) {
  gsub("\\n+", " ", x)
}

#' Remove tabs from text
#'
#' Removes all tabs from character vector.
#'
#' @param x Character vector.
#' @return Vector without tabs.
#' @export
chr_remove_tabs <- function(x) {
  gsub("\\t+", " ", x)
}

#' Remove [at] mentions from text
#'
#' Removes all [at] mentions from character vector.
#'
#' @param x Character vector.
#' @return Vector without screen names.
#' @export
chr_remove_mentions <- function(x) {
  gsub("@[[:alnum:]]+", " ", x)
}

#' Remove hashtags from text
#'
#' Removes all hashtags from character vector.
#'
#' @param x Character vector.
#' @return Vector without hashtags.
#' @export
chr_remove_hashtags <- function(x) {
  gsub("#[[:alpha:]]{1}[[:alnum:]]{0,}", "", x)
}


chr_remove_stopwords <- function(x, stopwords) {
  stopwords <- std_ascii(stopwords)
  stopwords <- c(stopwords,
                 title_case(stopwords),
                 toupper(stopwords),
                 tolower(stopwords))
  stopwords <- unique(stopwords)
  stopwords <- paste0("\\b", stopwords, "\\b")
  stopwords <- paste(stopwords, collapse = "|")
  x <- gsub(stopwords, " ", x)
  x <- gsub("\\s+[[:punct:]]+\\s+", " ", x)
  x <- gsub("\\s{2,}", " ", x)
  x <- gsub("^\\s+|\\s+$", "", x)
  x
}

#' Remove extra spaces from text
#'
#' Removes double+ spaces and trims white space from string ends.
#'
#' @param x Character vector.
#' @return Vector without extra spaces.
#' @export
chr_remove_ws <- function(x) {
  x <- gsub("\\s{2,}", " ", x)
  gsub("^\\s+|\\s+$", "", x)
}
