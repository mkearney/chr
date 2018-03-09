
## chr [![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)

R package for simple string manipulation

## Description

Clean, wrangle, and parse character \[string\] vectors using base
exclusively base R functions.

## Install

``` r
## install devtools is not alreasy installed
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

## install chr from github
devtools::install_github("mkearney/chr")

## load chr
library(chr)
```

## Usage

### Detect

**Detect** text patterns (an easy-to-use wrapper for `base::grep()` and
`base::grepl()`).

``` r
## return logical vector
chr_detect(letters, "a|b|c|x|y|z")
#>  [1]  TRUE  TRUE  TRUE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [12] FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE FALSE
#> [23] FALSE  TRUE  TRUE  TRUE

## return inverted logical values
chr_detect(letters, "a|b|c|x|y|z", invert = TRUE)
#>  [1] FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#> [12]  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE  TRUE
#> [23]  TRUE FALSE FALSE FALSE

## return matching positions
chr_detect(letters, "a|b|c|x|y|z", which = TRUE)
#> [1]  1  2  3 24 25 26

## return inverted matching positions
chr_detect(letters, "a|b|c|x|y|z", which = TRUE, invert = TRUE)
#>  [1]  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23

## return matching values
chr_detect(letters, "a|b|c|x|y|z", value = TRUE)
#> [1] "a" "b" "c" "x" "y" "z"

## return inverted matching values
chr_detect(letters, "a|b|c|x|y|z", value = TRUE, invert = TRUE)
#>  [1] "d" "e" "f" "g" "h" "i" "j" "k" "l" "m" "n" "o" "p" "q" "r" "s" "t"
#> [18] "u" "v" "w"
```

### Extract

**Extract** text patterns.

``` r
## some text strings
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
#> [[1]]
#> [1] "https://github.com" "http://twitter.com"
#> 
#> [[2]]
#> [1] NA
#> 
#> [[3]]
#> [1] "https://github.com"
#> 
#> [[4]]
#> [1] NA
#> 
#> [[5]]
#> [1] "https://mikew.com"

## extract all hashtags
chr_extract_hashtags(x)
#> [[1]]
#> [1] "MultipleLines"
#> 
#> [[2]]
#> [1] "istotally"
#> 
#> [[3]]
#> [1] NA
#> 
#> [[4]]
#> [1] "HasHashtags" "afew"        "ofthem"     
#> 
#> [[5]]
#> [1] NA

## extract mentions
chr_extract_mentions(x)
#> [[1]]
#> [1] "there"   "twitter"
#> 
#> [[2]]
#> [1] "one"
#> 
#> [[3]]
#> [1] NA
#> 
#> [[4]]
#> [1] NA
#> 
#> [[5]]
#> [1] "kearneymw"
```

### Count

**Count** number of matches.

``` r
## extract all there/their/they're
chr_count(x, "there|their|they\\S?re", ignore.case = TRUE)
#> [1] 1 1 1 0 0
```

### Remove

**Remove** text patterns.

``` r
## remove URLS
chr_remove_links(x)
#> [1] "this one is @there\n  has #MultipleLines  and \n   @twitter"   
#> [2] "this @one #istotally their and \n  some non-ascii symbols: ¿ ;"
#> [3] "this one is they're "                                          
#> [4] "this one #HasHashtags #afew #ofthem"                           
#> [5] "and more @kearneymw at "

## string together functions with magrittr pipe
library(magrittr)

## remove mentions and extra [white] spaces
chr_remove_mentions(x) %>%
  chr_remove_ws()
#> [1] "this one is has #MultipleLines https://github.com and http://twitter.com"
#> [2] "this #istotally their and some non-ascii symbols: ¿ ;"                   
#> [3] "this one is they're https://github.com"                                  
#> [4] "this one #HasHashtags #afew #ofthem"                                     
#> [5] "and more at https://mikew.com"

## remove hashtags
chr_remove_hashtags(x)
#> [1] "this one is @there\n  has  https://github.com and \n  http://twitter.com @twitter"
#> [2] "this @one  their and \n  some non-ascii symbols: ¿ ;"                             
#> [3] "this one is they're https://github.com"                                           
#> [4] "this one   "                                                                      
#> [5] "and more @kearneymw at https://mikew.com"

## remove hashtags, line breaks, and extra spaces
x %>%
  chr_remove_hashtags() %>%
  chr_remove_linebreaks() %>%
  chr_remove_ws()
#> [1] "this one is @there has https://github.com and http://twitter.com @twitter"
#> [2] "this @one their and some non-ascii symbols: ¿ ;"                          
#> [3] "this one is they're https://github.com"                                   
#> [4] "this one"                                                                 
#> [5] "and more @kearneymw at https://mikew.com"

## remove links and extract words
x %>%
  chr_remove_links() %>%
  chr_remove_mentions() %>%
  chr_extract_words()
#> [[1]]
#> [1] "this"          "one"           "is"            "has"          
#> [5] "MultipleLines" "and"          
#> 
#> [[2]]
#> [1] "this"      "istotally" "their"     "and"       "some"      "non-ascii"
#> [7] "symbols"  
#> 
#> [[3]]
#> [1] "this"    "one"     "is"      "they're"
#> 
#> [[4]]
#> [1] "this"        "one"         "HasHashtags" "afew"        "ofthem"     
#> 
#> [[5]]
#> [1] "and"  "more" "at"
```

### Replace

**Replace** text with string.

``` r
## replace their with they're
chr_replace(x, "their", "they're", ignore.case = TRUE)
#> [1] "this one is @there\n  has #MultipleLines https://github.com and \n  http://twitter.com @twitter"
#> [2] "this @one #istotally they're and \n  some non-ascii symbols: ¿ ;"                               
#> [3] "this one is they're https://github.com"                                                         
#> [4] "this one #HasHashtags #afew #ofthem"                                                            
#> [5] "and more @kearneymw at https://mikew.com"
```

ASCII functions currently *in progress*. For example, replace non-ASCII
symbols with similar ASCII characters (*work in progress*).

``` r
## ascii version
chr_replace_nonascii(x)
#> [1] "this one is @there\n  has #MultipleLines https://github.com and \n  http://twitter.com @twitter"
#> [2] "this @one #istotally their and \n  some non-ascii symbols: ? ;"                                 
#> [3] "this one is they're https://github.com"                                                         
#> [4] "this one #HasHashtags #afew #ofthem"                                                            
#> [5] "and more @kearneymw at https://mikew.com"
```

### n-grams

Create **ngram**s at the character-level.

``` r
## character vector
x <- c("Acme Pizza, Inc.", "Tom's Sports Equipment, LLC")

## 2 char level ngram
chr_ngram_char(x, n = 2L)
#> [[1]]
#>  [1] "Ac" "cm" "me" "e " " P" "Pi" "iz" "zz" "za" "a," ", " " I" "In" "nc"
#> [15] "c."
#> 
#> [[2]]
#>  [1] "To" "om" "m'" "'s" "s " " S" "Sp" "po" "or" "rt" "ts" "s " " E" "Eq"
#> [15] "qu" "ui" "ip" "pm" "me" "en" "nt" "t," ", " " L" "LL" "LC"

## 3 char level ngram in lower case and stripped of punctation and white space
chr_ngram_char(x, n = 3L, lower = TRUE, punct = TRUE, space = TRUE)
#> [[1]]
#>  [1] "acm" "cme" "mep" "epi" "piz" "izz" "zza" "zai" "ain" "inc"
#> 
#> [[2]]
#>  [1] "tom" "oms" "mss" "ssp" "spo" "por" "ort" "rts" "tse" "seq" "equ"
#> [12] "qui" "uip" "ipm" "pme" "men" "ent" "ntl" "tll" "llc"
```

### Contributions

Please note that this project is released with a [Contributor Code of
Conduct](CODE_OF_CONDUCT.md). By participating in this project you agree
to abide by its terms.
