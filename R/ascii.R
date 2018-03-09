#' Replace non-ascii with similar ascii characters
#'
#' Replace weird UTF values with equivalent(ish) ascii values.
#'
#' @param x Character vector with non-ascii characters
#' @return ASCII-friendly character vector.
#' @export
chr_replace_nonascii <- function(x) {
  ## spaces
  x <- gsub("\u00A0|\u200B|\u2060|\u3000|\uFEFF", "\u0020", x)

  ## exclamation mark
  x <- gsub("\u00A1|\u01C3|\u202C|\u203D|\u2762", "\u0021", x)

  ## quotation mark
  x <- gsub(
    "\u201C|\u201D|\u05F4|\u02BA|\u030B|\u030E|\u05F4|\u2033|\u3003",
    "\u0022", x)

  ## number sign
  x <- gsub("\u2114|\u2317|\u266F", "\u0023", x)

  ## dollar sign
  x <- gsub("\u00A4|\u20B1|\u1F4B2", "\u0024", x)

  ## percent signs
  x <- gsub("\u066A|\u2030|\u2031|\u2052", "\u0025", x)

  ## ampersands
  x <- gsub("\u204A|\u214B|\u1F674|\u0026amp;", "\u0026", x)

  ## apostrophe
  x <- gsub(
    "\u2018|\u2019|\u05F3|\u02B9|\u02Bc|\u02C8|\u0301|\u05F3|\u2032|\uA78C",
    "\u0027", x)

  ## asterisk
  x <- gsub("\u066D|\u204E|\u2217|\u26B9|\u2731", "\u002a", x)

  ## plus sign
  x <- gsub("\u2795", "\u002B", x)

  ## comma
  x <- gsub("\u2795", "\u002B", x)

  ## hyphen
  x <- gsub("\u2010|\u2011|\u2012|\u2013|\u2043|\u2212|\u10191", "\u002D", x)

  ## period
  x <- gsub("\u06D4|\u2E3C|\u3002", "\u002E", x)

  ## eplipses
  x <- gsub("\u2026", "\u002E\u002E\u002E", x)

  ## forward slash
  x <- gsub("\u0338|\u2044|\u2214", "\u002F", x)

  ## colon
  x <- gsub("\u0589|\u05C3|\u2236|\uA789", "\u003A", x)

  ## semicolon
  x <- gsub("\u037E|\u061B|\u204F", "\u003B", x)

  ## less than
  x <- gsub("\u2039|\u2329|\u27E8|\u3008", "\u003C", x)

  ## equal to
  x <- gsub("\u2261|\uA78A|\u10190", "\u003D", x)

  ## greater than
  x <- gsub("\u203A|\u232A|\u27E9|\u3009", "\u003E", x)

  ## question mark
  x <- gsub("\u00BF|\u037E|\u061F|\u203D|\u2048|\u2049", "\u003F", x)

  ## vertical line
  x <- gsub("\u01C0|\u05C0|\u2223|\u2758", "\u007C", x)

  ## tilde
  x <- gsub("\u02DC|\u0303|\u2053|\u223C|\uFF5E", "\u007E", x)

  ## convert rest to ascii
  iconv(x, to = "ascii", sub = "byte")
}


std_apos <- function(x) {
  gsub(paste0(
    "[[:alpha:]]+(\u2018|\u2019|\u05F3|\u02B9|\u02Bc|\u02C8|\u0301|",
    "\u05F3|\u2032|\uA78C)[[:alpha:]]+"),
    "\u0027", x)
}
