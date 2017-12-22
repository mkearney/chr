
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
## get all there/their/they're
chr_extract(
  rt$text[c(5, 9, 34, 76, 84, 149, 157, 256)], 
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
    ## 
    ## [[8]]
    ## [1] "they’re"

``` r
## do it again but return single-length values
chr_extract(
  rt$text[c(5, 9, 34, 76, 84, 149, 157, 256)], 
  "there|their|they\\S?re", 
  ignore.case = TRUE, 
  collapse = "+"
)
```

    ## [1] "their+their" "there"       "there"       "THERE"       "their"      
    ## [6] "they’re"     "they’re"     "they’re"

``` r
## extract all URLS
chr_extract_links(rt$text[1:10])
```

    ## [[1]]
    ## [1] "https://t.co/QkZ0L7baQF"
    ## 
    ## [[2]]
    ## [1] "https://t.co/zjXJlXW9Dw"
    ## 
    ## [[3]]
    ## [1] "https://t.co/K8sLk54m6K"
    ## 
    ## [[4]]
    ## [1] NA
    ## 
    ## [[5]]
    ## [1] "https://t.c…"
    ## 
    ## [[6]]
    ## [1] NA
    ## 
    ## [[7]]
    ## [1] NA
    ## 
    ## [[8]]
    ## [1] "https://t.co/vvrgUXHTZP"
    ## 
    ## [[9]]
    ## [1] NA
    ## 
    ## [[10]]
    ## [1] NA

``` r
## extract hashtags
chr_extract_hashtags(rt$text[78])
```

    ## [[1]]
    ## [1] "loveactually"         "leseigneurdesanneaux" "catalogne"           
    ## [4] "envoyespecial"

### Remove

**Remove** text patterns.

``` r
## remove URLS
chr_remove_links(rt$text[1:10])
```

    ##  [1] "How Dangerous Is The United Nations?  via @YouTube  @KassandraTroy 5 min. video."                                                                                       
    ##  [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ "                                                                                                                          
    ##  [3] "RT @TheDemCoalition: SEE-YA: A-hole CEO learns that racism doesn't pay  #TakeAKnee"                                                                                     
    ##  [4] "RT @Destruction969: I don't 'dash' any-fucking-where; least of all through snow"                                                                                        
    ##  [5] "RT @ZarrarKhuhro: All students who misbehave will have their names noted down and marks will be deducted from their final grade "                                       
    ##  [6] "@Hotpage_News Sales were slumping bc Papa John's was a vocal supporter of the NFL. The CEO tried to curb the loses with his statement. Sales will continue to tank now."
    ##  [7] "RT @opento: @guyverhofstadt @InesArrimadas @CiudadanosCs Get a grip!\nAre you trying to undermine EU values?"                                                           
    ##  [8] "I added a video to a @YouTube playlist  Glacier - Neos [Monstercat Release]"                                                                                            
    ##  [9] "RT @therealroseanne: how could we have fallen for Obama? OMG"                                                                                                           
    ## [10] "RT @WillThaRapper: Down talk my dawg sumn I could never do"

``` r
## string together functions with magrittr pipe
library(magrittr)

## remove mentions and extra [white] spaces
chr_remove_mentions(rt$text[1:10]) %>% 
  chr_remove_ws()
```

    ##  [1] "How Dangerous Is The United Nations? https://t.co/QkZ0L7baQF via 5 min. video."                                                                                 
    ##  [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ https://t.co/zjXJlXW9Dw"                                                                                           
    ##  [3] "RT : SEE-YA: A-hole CEO learns that racism doesn't pay https://t.co/K8sLk54m6K #TakeAKnee"                                                                      
    ##  [4] "RT : I don't 'dash' any-fucking-where; least of all through snow"                                                                                               
    ##  [5] "RT : All students who misbehave will have their names noted down and marks will be deducted from their final grade https://t.c…"                                
    ##  [6] "_News Sales were slumping bc Papa John's was a vocal supporter of the NFL. The CEO tried to curb the loses with his statement. Sales will continue to tank now."
    ##  [7] "RT : Get a grip!\nAre you trying to undermine EU values?"                                                                                                       
    ##  [8] "I added a video to a playlist https://t.co/vvrgUXHTZP Glacier - Neos [Monstercat Release]"                                                                      
    ##  [9] "RT : how could we have fallen for Obama? OMG"                                                                                                                   
    ## [10] "RT : Down talk my dawg sumn I could never do"

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

### Detect

**Detect** text patterns.

*in progress*

### ASCII standardization

Coerce non-ASCII symbols into similar ASCII characters (*work in progress*).

``` r
## compare before and after
Map(
  identical, chr_replace_nonascii(rt$text[c(1:5, 33, 49, 51, 57, 62)]), 
  rt$text[c(1:5, 33, 49, 51, 57, 62)], 
  USE.NAMES = FALSE
)
```

    ## [[1]]
    ## [1] TRUE
    ## 
    ## [[2]]
    ## [1] TRUE
    ## 
    ## [[3]]
    ## [1] TRUE
    ## 
    ## [[4]]
    ## [1] TRUE
    ## 
    ## [[5]]
    ## [1] FALSE
    ## 
    ## [[6]]
    ## [1] FALSE
    ## 
    ## [[7]]
    ## [1] FALSE
    ## 
    ## [[8]]
    ## [1] FALSE
    ## 
    ## [[9]]
    ## [1] FALSE
    ## 
    ## [[10]]
    ## [1] FALSE

``` r
## original
rt$text[c(1:5, 33, 49, 51, 57, 62)]
```

    ##  [1] "How Dangerous Is The United Nations? https://t.co/QkZ0L7baQF via @YouTube  @KassandraTroy 5 min. video."                                                                                                                                                                                                              
    ##  [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ https://t.co/zjXJlXW9Dw"                                                                                                                                                                                                                                                 
    ##  [3] "RT @TheDemCoalition: SEE-YA: A-hole CEO learns that racism doesn't pay https://t.co/K8sLk54m6K #TakeAKnee"                                                                                                                                                                                                            
    ##  [4] "RT @Destruction969: I don't 'dash' any-fucking-where; least of all through snow"                                                                                                                                                                                                                                      
    ##  [5] "RT @ZarrarKhuhro: All students who misbehave will have their names noted down and marks will be deducted from their final grade https://t.c…"                                                                                                                                                                         
    ##  [6] "regranned from @djfuriousstyles  -  Gotta make moves for ‘18....@vintagecrew202 Coming to… https://t.co/UJU7qxUYBu"                                                                                                                                                                                                   
    ##  [7] "I liked a @YouTube video https://t.co/ixj8oGWz4k N.E.R.D &amp; Rihanna - Lemon"                                                                                                                                                                                                                                       
    ##  [8] "\U0001f3b6\U0001f5e3BAAAAABY, YOU’VE BEEN GIVING ME HELL, YOU KNOW YOU SAID IT YOURSELF.\nThat I would find no other love,\nNow here I am, baby if I could get you up out my head. Maybe for a second now.\n\U0001f3b6I just can’t get over youuuu \nChasing my tail like a fool \nGirl you got me going right around"
    ##  [9] "You’re blessed with some great parents. Setting you up for success tbh https://t.co/dsy8PdTsJf"                                                                                                                                                                                                                       
    ## [10] "I’ve had a “get Metro Boomin in the studio with Brian eno” tweet in my drafts for months feel like that could really help metro level up https://t.co/yAqu93Myf8"

``` r
## ascii version
chr_replace_nonascii(rt$text[c(1:5, 33, 49, 51, 57, 62)])
```

    ##  [1] "How Dangerous Is The United Nations? https://t.co/QkZ0L7baQF via @YouTube  @KassandraTroy 5 min. video."                                                                                                                                                                                                              
    ##  [2] "Sadly true, u b trippin\U0001f926\U0001f3fd‍♂️ https://t.co/zjXJlXW9Dw"                                                                                                                                                                                                                                                 
    ##  [3] "RT @TheDemCoalition: SEE-YA: A-hole CEO learns that racism doesn't pay https://t.co/K8sLk54m6K #TakeAKnee"                                                                                                                                                                                                            
    ##  [4] "RT @Destruction969: I don't 'dash' any-fucking-where; least of all through snow"                                                                                                                                                                                                                                      
    ##  [5] "RT @ZarrarKhuhro: All students who misbehave will have their names noted down and marks will be deducted from their final grade https://t.c..."                                                                                                                                                                       
    ##  [6] "regranned from @djfuriousstyles  -  Gotta make moves for '18....@vintagecrew202 Coming to... https://t.co/UJU7qxUYBu"                                                                                                                                                                                                 
    ##  [7] "I liked a @YouTube video https://t.co/ixj8oGWz4k N.E.R.D & Rihanna - Lemon"                                                                                                                                                                                                                                           
    ##  [8] "\U0001f3b6\U0001f5e3BAAAAABY, YOU'VE BEEN GIVING ME HELL, YOU KNOW YOU SAID IT YOURSELF.\nThat I would find no other love,\nNow here I am, baby if I could get you up out my head. Maybe for a second now.\n\U0001f3b6I just can't get over youuuu \nChasing my tail like a fool \nGirl you got me going right around"
    ##  [9] "You're blessed with some great parents. Setting you up for success tbh https://t.co/dsy8PdTsJf"                                                                                                                                                                                                                       
    ## [10] "I've had a \"get Metro Boomin in the studio with Brian eno\" tweet in my drafts for months feel like that could really help metro level up https://t.co/yAqu93Myf8"
