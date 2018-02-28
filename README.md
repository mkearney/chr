
chr
---

R package for simple string manipulation

*this package is in early development*

Description
-----------

Clean, wrangle, and parse character \[string\] vectors using base exclusively base R functions.

Install
-------

``` r
## install from github
if (!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("mkearney/chr")

## load chr
library(chr)
```

Usage
-----

### `chr::detect()`

Use `chr_detect()` as a easy to use wrapper for base R's `grep()` and `grepl()` functions.

``` r
## return logical vector
chr_detect(letters, "a|b|c|x|y|z")

## return inverted logical values
chr_detect(letters, "a|b|c|x|y|z", invert = TRUE)

## return matching positions
chr_detect(letters, "a|b|c|x|y|z", which = TRUE)

## return inverted matching positions
chr_detect(letters, "a|b|c|x|y|z", which = TRUE, invert = TRUE)

## return matching values
chr_detect(letters, "a|b|c|x|y|z", value = TRUE)

## return inverted matching values
chr_detect(letters, "a|b|c|x|y|z", value = TRUE, invert = TRUE)
```

### Extract

**Extract** text patterns.

``` r
## some strings with 'their', 'there', or 'they're
x <- c("this one is @there
  has #MultipleLines https://github.com and 
  http://twitter.com @twitter",
  "this @one #istotally their and 
  some non-ascii symbols: \u00BF \u037E", 
  "this one is they're https://github.com", 
  "this one #HasHashtags #afew #ofthem", 
  "and more @kearneymw at https://mikew.com")

## extract all URLS
chr_extract_links(x)

## extract all hashtags
chr_extract_hashtags(x)

## extract mentions
chr_extract_mentions(x)
```

### Count

**Count** number of matches.

``` r
## extract all there/their/they're
chr_count(x, "there|their|they\\S?re", ignore.case = TRUE)
```

### Remove

**Remove** text patterns.

``` r
## remove URLS
chr_remove_links(x)

## string together functions with magrittr pipe
library(magrittr)

## remove mentions and extra [white] spaces
chr_remove_mentions(x) %>%
  chr_remove_ws()

## remove hashtags
chr_remove_hashtags(x)

## remove hashtags, line breaks, and extra spaces
x %>%
  chr_remove_hashtags() %>%
  chr_remove_linebreaks() %>%
  chr_remove_ws()

## remove links and extract words
x %>%
  chr_remove_links() %>%
  chr_remove_mentions() %>%
  chr_extract_words()
```

### Replace

**Replace** text with string.

``` r
## some text
x <- c("Acme Pizza, Inc.", "Tom's Sports Equipment, LLC")

## replace acme with Kearney
chr_replace(x, "acme", "Kearney", ignore.case = TRUE)
```

ASCII functions currently *in progress*. For example, replace non-ASCII symbols with similar ASCII characters (*work in progress*).

``` r
## ascii version
chr_replace_nonascii(x)
```

### n-grams

Create **ngram**s at the character-level.

``` r
## character vector
x <- c("Acme Pizza, Inc.", "Tom's Sports Equipment, LLC")

## 2 char level ngram
chr_ngram_char(x, n = 2L)

## 3 char level ngram in lower case and stripped of punctation and white space
chr_ngram_char(x, n = 3L, lower = TRUE, punct = TRUE, space = TRUE)
```

### Contributions

Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree to abide by its terms.
