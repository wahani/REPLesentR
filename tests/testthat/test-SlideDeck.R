testthat::context("SlideDeck")

testthat::test_that("", {
  fname <- system.file("example.Rmd", package = "slider", mustWork = TRUE)
  rawText <- Read()$auto(fname, quiet = TRUE)
  slideDeck <- SlideDeck()$new(rawText)
  testthat::expect_true(length(slideDeck) == 6)
  lapply(slideDeck, function(slide) {
    testthat::expect_true(all(c("content", "format", "number") %in% names(slide)))
  })
})
