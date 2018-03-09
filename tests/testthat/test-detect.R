context("test-detect.R")

test_that("chr_detect", {
  expect_true(chr_detect("asdf", "asdf"))
  expect_true(chr_detect("asdf", "asdf", which = TRUE) == 1)
  expect_true(chr_detect("asdf", "asdf", value = TRUE) == "asdf")
  expect_true(chr_detect("ASDF", "asdf", invert = TRUE))
})
