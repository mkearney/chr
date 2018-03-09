context("test-chr_extract-r.R")

test_that("multiplication works", {
  ## some text strings
  x <- c("this one is @there
    has #MultipleLines https://github.com and
    http://twitter.com @twitter",
    "this @one #istotally their and
    some non-ascii symbols: \u00BF \u037E",
    "this one is they're https://github.com",
    "this one #HasHashtags #afew #ofthem",
    "and more @kearneymw at https://mikew.com")

  ## extract all
  extall <- chr_extract(x, "is")
  expect_true(is.list(extall))
  expect_true(length(extall) == 5)
  expect_true(length(extall[[1]]) == 2)
  expect_true(is.na(extall[[5]]))

  ## extract first
  extfirst <- chr_extract_first(x, "is")
  expect_true(is.character(extfirst))
  expect_true(length(extfirst) == 4)
  expect_true(all(extfirst == "is"))

  ## extract all URLS
  links <- chr_extract_links(x)
  expect_true(is.list(links))
  expect_true(length(links) == 5)
  expect_true(length(links[[1]]) == 2)
  expect_true(is.na(links[[2]]))

  ## extract all hashtags
  hashtags <- chr_extract_hashtags(x)
  expect_true(is.list(hashtags))
  expect_true(length(hashtags) == 5)
  expect_true(length(hashtags[[4]]) == 3)
  expect_true(is.na(hashtags[[5]]))

  ## extract mentions
  mentions <- chr_extract_mentions(x)
  expect_true(is.list(mentions))
  expect_true(length(mentions) == 5)
  expect_true(length(mentions[[1]]) == 2)
  expect_true(is.na(mentions[[4]]))
})
