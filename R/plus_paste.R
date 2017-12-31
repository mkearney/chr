

#' Add (paste) together character vectors
#'
#' Paste or paste0 character vectors using the plus operator.
#'
#' @param e1 lhs
#' @param e2 rhs
#' @return Computed value
#' @examples
#' ## normal plus operator
#' 20 + 1
#' Sys.Date() + 5
#' matrix(1:4, 2, 2) + matrix(1:4, 2, 2)
#' array(1:8, c(2, 2, 2)) + array(1:8, c(2, 2, 2))
#'
#' ## normal errors
#' Sys.Date() + Sys.Date()
#'
#' ## paste together characters
#' "this" + "that"
#'
#' ## or characters and numbers
#' "this" + 2000
#' 2000 + "that"
#'
#' ## ignores missing
#' c(NA, "this") + c("that", NA) + c("other", "other")
#'
#' ## add space to behave like paste
#' "this" + " that"
#' "this " + "that"
#'
#' ## string together any number of character vectors
#' "this " + "that " + "and the other"
#' "ABC_" + letters + "_XYZ"
#' letters + letters
#' "T" + "his " + "that " + "and " + "the other."
#'
#'
#' @method + character
#' @export
"+.character" <- function(e1, e2) {
  unlist(Map("plus_character", e1, e2, USE.NAMES = FALSE))
}

`plus_character` <- function(e1, e2) {
  if (is.na(e1)) e1 <- ""
  if (is.na(e2)) e2 <- ""
  paste0(e1, e2)
}

#' @export
`+` <- function(e1, e2) {
   if (is.character(e1) || is.character(e2)) {
     return(try(`+.character`(e1, e2)))
   }
   try(.Primitive("+")(e1, e2))
}

#' @export
"%+%" <- `+.character`
