
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

`chr` offers lightweight functionality similar to [`stringr`](https://github.com/tidyverse/stringr). For example, say you have some text that needs taming, e.g., Twitter data:

``` r
## get text to manipulate
rt <- rtweet::search_tweets("lang:en", n = 500)
```

### Extract

**Extract** text patterns.

``` r
## some tweets with 'their', 'there', or 'they're'
rt$text[c(5, 9, 34, 76, 84, 157, 256)]
```

    ## [1] "RT @ZarrarKhuhro: All students who misbehave will have their names noted down and marks will be deducted from their final grade https://t.c…"
    ## [2] "RT @therealroseanne: how could we have fallen for Obama? OMG"                                                                                
    ## [3] "RT @AlfredoFlores: I look so damn happy back there \U0001f602\U0001f926\U0001f3fd‍♂️ https://t.co/NP0Xw2FedC"                                  
    ## [4] "@JiggyJehad THERE’S A RARE ROBTHEHIPPIE DOLLAR IN THAT HOE"                                                                                  
    ## [5] "RT @MatthewWynia: The most disturbing aspect of this is the $$$ given to disease groups, which has basically bought their silence on high d…"
    ## [6] "RT @FIirtationship: GIRLS CAN READ GIRLS. WE KNOW GIRLS BC WE ARE GIRLS. we know the shit they do how they’re gonna do it the way they flir…"
    ## [7] "RT @40oz_VAN: Don’t think because someone’s not bragging they’re not lit."

``` r
## extract all there/their/they're
chr_extract(
  rt$text[c(5, 9, 34, 76, 84, 157, 256)], 
  "there|their|they\\S?re", 
  ignore.case = TRUE
)
```

    ## [[1]]
    ## [1] "their" "their"
    ## 
    ## [[2]]
    ## [1] "there"
    ## 
    ## [[3]]
    ## [1] "there"
    ## 
    ## [[4]]
    ## [1] "THERE"
    ## 
    ## [[5]]
    ## [1] "their"
    ## 
    ## [[6]]
    ## [1] "they’re"
    ## 
    ## [[7]]
    ## [1] "they’re"

``` r
## do it again but return single-length values
chr_extract(
  rt$text[c(5, 9, 34, 76, 84, 157, 256)], 
  "there|their|they\\S?re", 
  ignore.case = TRUE, 
  collapse = "+"
)
```

    ## [1] "their+their" "there"       "there"       "THERE"       "their"      
    ## [6] "they’re"     "they’re"

``` r
## extract first there/their/they're
chr_extract_first(
  rt$text[c(5, 9, 34, 76, 84, 157, 256)], 
  "there|their|they\\S?re", 
  ignore.case = TRUE
)
```

    ## [1] "their"   "there"   "there"   "THERE"   "their"   "they’re" "they’re"

``` r
## tweets with URL links
rt$text[1:3]
```

    ## [1] "How Dangerous Is The United Nations? https://t.co/QkZ0L7baQF via @YouTube  @KassandraTroy 5 min. video."  
    ## [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ https://t.co/zjXJlXW9Dw"                                     
    ## [3] "RT @TheDemCoalition: SEE-YA: A-hole CEO learns that racism doesn't pay https://t.co/K8sLk54m6K #TakeAKnee"

``` r
## extract all URLS
chr_extract_links(rt$text[1:3])
```

    ## [[1]]
    ## [1] "https://t.co/QkZ0L7baQF"
    ## 
    ## [[2]]
    ## [1] "https://t.co/zjXJlXW9Dw"
    ## 
    ## [[3]]
    ## [1] "https://t.co/K8sLk54m6K"

``` r
## tweet with hashtags
rt$text[78]
```

    ## [1] "Cliquez ici ----&gt; \n#loveactually\n#leseigneurdesanneaux\n#catalogne\n#envoyespecial\npatrick swayze\nrajoy\ngandalf\nhugh grant  \nhttps://t.co/2l29HbAQRM"

``` r
## extract all hashtags
chr_extract_hashtags(rt$text[c(40, 41, 77, 78)])
```

    ## [[1]]
    ## [1] "Etsy"         "newyearseve"  "2017"         "partydecor"  
    ## [5] "partyfavor"   "holiday"      "gifts"        "etsychaching"
    ## 
    ## [[2]]
    ## [1] NA
    ## 
    ## [[3]]
    ## [1] "Goldman"   "Bloomberg"
    ## 
    ## [[4]]
    ## [1] "loveactually"         "leseigneurdesanneaux" "catalogne"           
    ## [4] "envoyespecial"

``` r
## tweet with and without mentions
rt$text[1:2]
```

    ## [1] "How Dangerous Is The United Nations? https://t.co/QkZ0L7baQF via @YouTube  @KassandraTroy 5 min. video."
    ## [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ https://t.co/zjXJlXW9Dw"

``` r
## extract mentions
chr_extract_mentions(rt$text[1:2])
```

    ## [[1]]
    ## [1] "YouTube"       "KassandraTroy"
    ## 
    ## [[2]]
    ## [1] NA

### Count

**Count** number of matches.

``` r
## extract all there/their/they're
chr_count(
  rt$text[c(5, 9, 34, 76, 84, 157, 256)], 
  "there|their|they\\S?re", 
  ignore.case = TRUE
)
```

    ## [1] 2 1 1 1 1 1 1

### Remove

**Remove** text patterns.

``` r
## remove URLS
chr_remove_links(rt$text[1:3])
```

    ## [1] "How Dangerous Is The United Nations?  via @YouTube  @KassandraTroy 5 min. video."  
    ## [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ "                                     
    ## [3] "RT @TheDemCoalition: SEE-YA: A-hole CEO learns that racism doesn't pay  #TakeAKnee"

``` r
## string together functions with magrittr pipe
library(magrittr)

## remove mentions and extra [white] spaces
chr_remove_mentions(rt$text[1:3]) %>% 
  chr_remove_ws()
```

    ## [1] "How Dangerous Is The United Nations? https://t.co/QkZ0L7baQF via 5 min. video."           
    ## [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ https://t.co/zjXJlXW9Dw"                     
    ## [3] "RT : SEE-YA: A-hole CEO learns that racism doesn't pay https://t.co/K8sLk54m6K #TakeAKnee"

``` r
## remove hashtags
chr_remove_hashtags(rt$text[78])
```

    ## [1] "Cliquez ici ----&gt; \n\n\n\n\npatrick swayze\nrajoy\ngandalf\nhugh grant  \nhttps://t.co/2l29HbAQRM"

``` r
## remove hashtags, line breaks, and extra spaces
rt$text[78] %>%
  chr_remove_hashtags() %>%
  chr_remove_linebreaks() %>%
  chr_remove_ws()
```

    ## [1] "Cliquez ici ----&gt; patrick swayze rajoy gandalf hugh grant https://t.co/2l29HbAQRM"

``` r
## remove links and extract words
rt$text[1:3] %>%
  chr_remove_links() %>%
  chr_remove_mentions() %>%
  chr_extract_words()
```

    ## [[1]]
    ##  [1] "How"       "Dangerous" "Is"        "The"       "United"   
    ##  [6] "Nations"   "via"       "5"         "min"       "video"    
    ## 
    ## [[2]]
    ## [1] "Sadly"   "true"    "u"       "b"       "trippin"
    ## 
    ## [[3]]
    ##  [1] "RT"        "SEE-YA"    "A-hole"    "CEO"       "learns"   
    ##  [6] "that"      "racism"    "doesn't"   "pay"       "TakeAKnee"

### Detect

**Detect** text patterns.

``` r
## extract all there/their/they're
chr_detect(
  rt$text[c(5, 9, 34, 76, 84, 157, 256)], 
  "there|their|they\\S?re", 
  ignore.case = TRUE
)
```

    ## [1] TRUE TRUE TRUE TRUE TRUE TRUE TRUE

### Replace

**Replace** text with string.

``` r
## some text
x <- c("Acme Pizza, Inc.", "Tom's Sports Equipment, LLC")

## replace acme with Kearney
chr_replace(x, "acme", "Kearney", ignore.case = TRUE)
```

    ## [1] "Kearney Pizza, Inc."         "Tom's Sports Equipment, LLC"

ASCII functions currently *in progress*. For example, replace non-ASCII symbols with similar ASCII characters (*work in progress*).

``` r
## compare before and after
Map(
  identical, chr_replace_nonascii(rt$text[c(1, 51, 57, 62)]), 
  rt$text[c(1, 51, 57, 62)], 
  USE.NAMES = FALSE
)
```

    ## [[1]]
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] FALSE
    ## 
    ## [[3]]
    ## [1] FALSE
    ## 
    ## [[4]]
    ## [1] FALSE

``` r
## original
rt$text[c(51, 57, 62)]
```

    ## [1] "\U0001f3b6\U0001f5e3BAAAAABY, YOU’VE BEEN GIVING ME HELL, YOU KNOW YOU SAID IT YOURSELF.\nThat I would find no other love,\nNow here I am, baby if I could get you up out my head. Maybe for a second now.\n\U0001f3b6I just can’t get over youuuu \nChasing my tail like a fool \nGirl you got me going right around"
    ## [2] "You’re blessed with some great parents. Setting you up for success tbh https://t.co/dsy8PdTsJf"                                                                                                                                                                                                                       
    ## [3] "I’ve had a “get Metro Boomin in the studio with Brian eno” tweet in my drafts for months feel like that could really help metro level up https://t.co/yAqu93Myf8"

``` r
## ascii version
chr_replace_nonascii(rt$text[c(51, 57, 62)])
```

    ## [1] "\U0001f3b6\U0001f5e3BAAAAABY, YOU'VE BEEN GIVING ME HELL, YOU KNOW YOU SAID IT YOURSELF.\nThat I would find no other love,\nNow here I am, baby if I could get you up out my head. Maybe for a second now.\n\U0001f3b6I just can't get over youuuu \nChasing my tail like a fool \nGirl you got me going right around"
    ## [2] "You're blessed with some great parents. Setting you up for success tbh https://t.co/dsy8PdTsJf"                                                                                                                                                                                                                       
    ## [3] "I've had a \"get Metro Boomin in the studio with Brian eno\" tweet in my drafts for months feel like that could really help metro level up https://t.co/yAqu93Myf8"

### n-grams

Create **ngram**s at the character.

``` r
## character vector
x <- c("Acme Pizza, Inc.", "Tom's Sports Equipment, LLC")

## 2 char level ngram
chr_ngram_char(x, n = 2L)
```

    ## [[1]]
    ##  [1] "Ac" "cm" "me" "e " " P" "Pi" "iz" "zz" "za" "a," ", " " I" "In" "nc"
    ## [15] "c."
    ## 
    ## [[2]]
    ##  [1] "To" "om" "m'" "'s" "s " " S" "Sp" "po" "or" "rt" "ts" "s " " E" "Eq"
    ## [15] "qu" "ui" "ip" "pm" "me" "en" "nt" "t," ", " " L" "LL" "LC"

``` r
## 3 char level ngram in lower case and stripped of punctation and white space
chr_ngram_char(x, n = 3L, lower = TRUE, punct = TRUE, space = TRUE)
```

    ## [[1]]
    ##  [1] "acm" "cme" "mep" "epi" "piz" "izz" "zza" "zai" "ain" "inc"
    ## 
    ## [[2]]
    ##  [1] "tom" "oms" "mss" "ssp" "spo" "por" "ort" "rts" "tse" "seq" "equ"
    ## [12] "qui" "uip" "ipm" "pme" "men" "ent" "ntl" "tll" "llc"
